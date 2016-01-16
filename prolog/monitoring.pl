:- module(monitoring,
	[  
		completed_task/1,			% ?Task
		difference_task/2,			% ?Task, ?Diff
		assert_task/3,				% +Name, +Estimation, +Done
		retract_task/1,				% +Name
		update_task/2				% +Name, +Done
	]).


completed_task(Task) :- task(Task, Done, Done).

difference_task(Task, Diff) :-
	task(Task, Estimation, Done), Diff is Estimation - Done.



:- dynamic task/3.

assert_task(Name, Estimation, Done) :-
	assert(task(Name, Estimation, Done)).
	  
retract_task(Name) :-
	retractall(task(Name, _, _)).

update_task(Name, Done) :-
	task(Name, Estimation, _),
	retract_task(Name),
	assert_task(Name, Estimation, Done).
