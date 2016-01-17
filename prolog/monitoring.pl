:- module(monitoring,
	[  
		task/5,
		iteration/4,
		discrepancy/1,
		classify_iteration/2,
		historical_completeness/1,
		iteration_to_complete/2,
		iteration_latest_tasks/2,
		completed_tasks/2,
		completed_task/1,
		completed_task/2,
		earliest_task/3,
		latest_task/1,
		latest_task/3,
		difference_task/3,
		difference_task/4,
		assert_task/3,
		retract_task/5,
		update_task/3,
		assert_iteration/3,
		retract_iteration/1,
		iteration_task/2
	]).

:- use_module(library(lambda)).


discrepancy(high).
discrepancy(low).

classify_iteration(IdIteration, Discrepancy) :-
	iteration_to_complete(IdIteration, ToComplete),
	historical_completeness(Completeness),
	discrepancies(ToComplete, Completeness, [], Discrepancies),
	sumlist(Discrepancies, Sum),
	(
		length(Discrepancies, Len),
		Sum >= Len,
		Discrepancy = discrepancy(high), !
	);(
		Discrepancy = discrepancy(low)
	).

discrepancies(_, [], Discrepancies, Discrepancies).
discrepancies(ToComplete, [Value|Values], Acc, Discrepancies) :-
	Discrepancy is ToComplete + abs(Value),
	append([Discrepancy], Acc, NewAcc),
	discrepancies(ToComplete, Values, NewAcc, Discrepancies).

historical_completeness(Values) :-
	get_time(Today),
	findall(It, (iteration(It, _, End, _), End < Today), Its),
	historical_completeness(Its, [], Values).
historical_completeness([], Values, Values).
historical_completeness([It|Its], Acc, Values) :-
	iteration_to_complete(It, ToComplete),
	append([ToComplete], Acc, NewAcc),
	historical_completeness(Its, NewAcc, Values).

iteration_to_complete(IdIteration, ToComplete) :-
	iteration_latest_tasks(IdIteration, Tasks),
	calc_iteration_to_complete(Tasks, 0, ToComplete).
calc_iteration_to_complete([], ToComplete, ToComplete).
calc_iteration_to_complete([Task|Tasks], Acc, ToComplete) :-
	difference_task(Task, Diff),
	NewAcc is Diff + Acc,
	calc_iteration_to_complete(Tasks, NewAcc, ToComplete).

iteration_latest_tasks(IdIteration, Tasks) :-
	iteration(IdIteration, _, _, AllTasks),
	include(latest_task, AllTasks, Tasks).

completed_tasks(IdIteration, CompletedTasks) :-
	iteration_latest_tasks(IdIteration, Tasks),
	include(completed_task, Tasks, CompletedTasks).

completed_task(Task) :-
	Task = task(Id, Name, _, _, _),
	completed_task(Id, Name).

completed_task(Id, Name) :-
	task(Id, Name, Done, Done, _).

completed_task(Id, Name, Time) :-
	task(Id, Name, Done, Done, Time).

earliest_task(Id, Name, Time) :-
	task(Id, Name, _, _, Time),
	\+ (task(Id, Name, _, _, Time2), Time > Time2).

latest_task(Task) :-
	Task = task(Id, Name, _, _, Time),
	\+ (task(Id, Name, _, _, Time2), Time < Time2).

latest_task(Id, Name, Time) :-
	task(Id, Name, _, _, Time),
	\+ (task(Id, Name, _, _, Time2), Time < Time2).

difference_task(Task, Diff) :-
	Task = task(Id, Name, _, _, Time),
	difference_task(Id, Name, Time, Diff).

difference_task(Id, Name, Diff) :-
	latest_task(Id, Name, TimeStamp),
	difference_task(Id, Name, TimeStamp, Diff).

difference_task(Id, Name, TimeStamp, Diff) :-
	task(Id, Name, Estimation, Done, TimeStamp),
	Diff is Estimation - Done.



:- dynamic task/5, iteration/4.
% task(Id, Name, Estimation, Done, TimeStamp).
% iteration(Id, Start, End, Tasks).

assert_task(Id, Name, Estimation) :-
	get_time(TimeStamp),
	assert(task(Id, Name, Estimation, 0, TimeStamp)).
	  
retract_task(Id, Name, Estimation, Done, TimeStamp) :-
	retractall(task(Id, Name, Estimation, Done, TimeStamp)).

update_task(Id, Name, Done) :-
	task(Id, Name, Estimation, _, _),
	get_time(TimeStamp),
	assert_task(Id, Name, Estimation, Done, TimeStamp).

assert_iteration(Id, Start, End) :-
	assert(iteration(Id, Start, End, [])).

retract_iteration(IdIteration) :-
	retractall(iteration(IdIteration, _, _)).

iteration_task(IdIteration, Task) :-
	compound(Task),
	iteration(IdIteration, Start, End, Tasks),
	\+ (member(Task, Tasks)),
	Task =.. [task, _, _, _, _, Time],
	Time >= Start, Time =< End,
	append(Tasks, [Task], NewTasks),
	assert(iteration(IdIteration, Start, End, NewTasks)),
	retractall(iteration(IdIteration, Start, End, Tasks)).

