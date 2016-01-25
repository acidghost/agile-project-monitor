:- module(monitoring,
	[
		velocity_chart/5
	]).


velocity_chart(ProjectId, Current, Mean, Percentile66, Percentile33) :-
	project_iterations(ProjectId, Its),
	current_velocity_difference(ProjectId, Current),
	velocity_chart(Its, [], Mean, Percentile66, Percentile33).
velocity_chart([It|Its], Differences, Mean, Percentile66, Percentile33) :-
	iteration(It, Start, End),
	velocity_difference(It, Difference),
	append(Difference, Differences, NewDifferences),
	velocity_chart(Its, NewDifferences, Mean, Percentile66, Percentile33).
velocity_chart([], Differences, Mean, Percentile66, Percentile33) :-
	msort(Differences, Sorted),
	Mean is 0, Percentile66 is 1, Percentile33 is 2.

project_iterations(ProjectId, ItIds) :-
	project(ProjectId, _, PjStart, PjEnd, _, _),
	findall(ItId, (
			project_iteration(ProjectId, ItId),
			iteration(ItId, ItStart, ItEnd),
			ItStart >= PjStart, ItStart < PjEnd,
			ItEnd > PjStart, ItEnd =< PjEnd),
		ItIds
	).

iteration_updates(ItId, UpdateIds) :-
	iteration(ItId, Start, End),
	findall(UpdateId, (
			task_update(UpdateId, _, When, _, _),
			When >= Start, When =< End),
		UpdateIds
	).

iteration_updates(ItId, When, UpdateIds) :-
	findall(UpdateId, task_update(UpdateId, _, When, _, _), UpdateIds). 

latest_iteration(ProjectId, ItId, Start, End) :-
	project_iteration(ProjectId, ItId),
	iteration(ItId, Start, End),
	\+ (project_iteration(ProjectId, ItId2), iteration(ItId2, _, End2), ItId \= ItId2, End < End2).

velocity_difference(ItId, Difference) :-
	total_initial_estimation(ItId, TotInitialEstimation),
	total_remaining_effort(ItId, TotRemainingEffort),
	Difference is abs(TotInitialEstimation - TotRemainingEffort).

current_velocity_difference(ProjectId, Current) :-
	latest_iteration(ProjectId, ItId, _, _),
	velocity_difference(ItId, Current).

collect_initial_estimations(ItId, When, InitialEstimations) :-
	iteration_updates(ItId, When, UpdateIds),
	findall(InitialEstimation, (
		task_update(UpdateId, _, When, InitialEstimation, _),
		member(UpdateId, UpdateIds)
	), InitialEstimations).

collect_remaining_effort(ItId, When, RemainingEfforts) :-
	iteration_updates(ItId, When, UpdateIds),
	findall(Remaining, (
		task_update(UpdateId, _, When, Remaining, _),
		member(UpdateId, UpdateIds)
	), RemainingEfforts).

total_initial_estimation(ItId, TotInitialEstimation) :-
	iteration(ItId, Start, _),
	collect_initial_estimations(ItId, Start, InitialEstimations),
	sum(InitialEstimations, TotInitialEstimation).

total_remaining_effort(ItId, TotRemainingEffort) :-
	iteration(ItId, _, End),
	collect_remaining_effort(ItId, End, RemainingEfforts),
	sum(RemainingEfforts, TotRemainingEffort).

iteration_day_difference(ItId, When, Difference) :-
	collect_initial_estimations(ItId, When, InitialEstimations),
	collect_remaining_effort(ItId, When, Remainings),
	sum(InitialEstimations, TotEstimation),
	sum(Remainings, TotRemaining),
	Difference is TotEstimation - TotRemaining.


:- dynamic	project/6,
			iteration/3,
			project_iteration/2,
			task/4,
			task_update/5,
			project_task/2.

% project(Id, Name, Start, End, IterationSize, Unit)
% iteration(Id, Start, End)
% project_iteration(ProjectId, IterationId)
% task(Id, Name, Story, Labels)
% task_update(UpdateId, TaskId, When, Initial, Remaining)
% project_task(ProjectId, TaskId)
