:- module(monitoring,
	[  
		completed_task/2,
		earliest_task/3,
		latest_task/3,
		difference_task/3,
		difference_task/4,
		assert_task/3,
		retract_task/5,
		update_task/3
	]).


completed_task(Id, Name) :- task(Id, Name, Done, Done, _).

earliest_task(Id, Name, Time) :-
	task(Id, Name, _, _, Time),
	\+ (task(Id, Name, _, _, Time2), Time > Time2).

latest_task(Id, Name, Time) :-
	task(Id, Name, _, _, Time),
	\+ (task(Id, Name, _, _, Time2), Time < Time2).

difference_task(Id, Name, Diff) :-
	oldest_task(Id, Name, TimeStamp),
	difference_task(Id, Name, Diff, TimeStamp).

difference_task(Id, Name, Diff, TimeStamp) :-
	task(Id, Name, Estimation, Done, TimeStamp),
	Diff is Estimation - Done.



:- dynamic task/5.
% task(Id, Name, Estimation, Done, TimeStamp).

assert_task(Id, Name, Estimation) :-
	get_time(TimeStamp),
	assert(task(Id, Name, Estimation, 0, TimeStamp)).
	  
retract_task(Id, Name, Estimation, Done, TimeStamp) :-
	retractall(task(Id, Name, Estimation, Done, TimeStamp)).

update_task(Id, Name, Done) :-
	task(Id, Name, Estimation, _, _),
	get_time(TimeStamp),
	assert_task(Id, Name, Estimation, Done, TimeStamp).
