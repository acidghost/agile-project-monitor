:- module(monitoring,
	[
		velocity_chart/5,
		burndown_chart/4,
		aggregated_burndown/6,
		aggregated_burndown_discrepancy/5,
		velocity_chart_discrepancy/4,

		project/6,
		iteration/3,
		project_iteration/2,
		task/4,
		task_update/5,
		project_task/2
	]).


:- dynamic
	project/6,
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

:-	getenv("AGILE_SCENARIO", Scenario), consult(Scenario); !.


velocity_chart_discrepancy(0, _, _, none).
velocity_chart_discrepancy(Current, Percentile66, _, high) :-
	Current > Percentile66.
velocity_chart_discrepancy(Current, Percentile66, Percentile33, medium) :-
	Current >= Percentile33, Current =< Percentile66.
velocity_chart_discrepancy(Current, _, Percentile33, low) :-
	Current < Percentile33.

aggregated_burndown_discrepancy(behind, Behind, _, _, Discrepancy) :-
	aggregated_burndown_discrepancy(behind, Behind, Discrepancy).
aggregated_burndown_discrepancy(on_schedule, _, OnSchedule, _, Discrepancy) :-
	aggregated_burndown_discrepancy(on_schedule, OnSchedule, Discrepancy).
aggregated_burndown_discrepancy(ahead, _, _, Ahead, Discrepancy) :-
	aggregated_burndown_discrepancy(ahead, Ahead, Discrepancy).
aggregated_burndown_discrepancy(on_schedule, _, none).
aggregated_burndown_discrepancy(_, Percentage, low) :- Percentage > 0.66.
aggregated_burndown_discrepancy(_, Percentage, medium) :-
	Percentage >= 0.33, Percentage =< 0.66.
aggregated_burndown_discrepancy(_, Percentage, high) :- Percentage < 0.33.

aggregated_burndown(ProjectId, Current, Mean, Behind, OnSchedule, Ahead) :-
	latest_iteration(ProjectId, _, _, End),
	aggregated_burndown(ProjectId, End, Current, Mean, Behind, OnSchedule, Ahead).
aggregated_burndown(ProjectId, When, Current, Mean, Behind, OnSchedule, Ahead) :-
	project_iterations(ProjectId, Its),
	aggregated_burndown(Its, When, [], Current, Mean, Behind, OnSchedule, Ahead).
aggregated_burndown([It|Its], When, Statuses, Current, Mean, Behind, OnSchedule, Ahead) :-
	(
		burndown_chart(It, ItDays, _, ItStatuses),
		member(When, ItDays),
		nth0(Index, ItDays, When),
		nth0(Index, ItStatuses, Current),
		delete(ItStatuses, Current, ItStatuses2),
		append(Statuses, ItStatuses2, NewStatuses),
		aggregated_burndown(Its, When, NewStatuses, Current, Mean, Behind, OnSchedule, Ahead)
	);
	(
		burndown_chart(It, _, _, ItStatuses),
		append(Statuses, ItStatuses, NewStatuses),
		aggregated_burndown(Its, When, NewStatuses, Current, Mean, Behind, OnSchedule, Ahead)
	), !.
aggregated_burndown([], _, Statuses, _, Mean, Behind, OnSchedule, Ahead) :-
	length(Statuses, Total),
	include(=(behind), Statuses, BehindS), length(BehindS, BehindL), Behind is BehindL / Total,
	include(=(on_schedule), Statuses, OnScheduleS), length(OnScheduleS, OnScheduleL), OnSchedule is OnScheduleL / Total,
	include(=(ahead), Statuses, AheadS), length(AheadS, AheadL), Ahead is AheadL / Total,
	List = [Behind, OnSchedule, Ahead],
	max_list(List, Max),
	nth0(Index, List, Max),
	nth0(Index, [behind, on_schedule, ahead], Mean).

burndown_status(Difference, Status) :- Difference =< -0.66, Status = behind, !.
burndown_status(Difference, Status) :- Difference > -0.66, Difference < 0.66, Status = on_schedule, !.
burndown_status(Difference, Status) :- Difference >= 0.66, Status = ahead.

burndown_chart(ItId, Days, Differences, Statuses) :-
	iteration_days(ItId, Days),
	burndown_chart(ItId, Days, Days, [], Differences, Statuses).
burndown_chart(ItId, [Day|Days], AllDays, Acc, Differences, Statuses) :-
	length(Acc, ItDay),
	iteration_day_difference(ItId, ItDay, Day, Difference),
	append(Acc, [Difference], NewAcc),
	burndown_chart(ItId, Days, AllDays, NewAcc, Differences, Statuses).
burndown_chart(_, [], _, Differences, Differences, Statuses) :-
	maplist(burndown_status, Differences, Statuses),
	!. % FIXME

velocity_chart(ProjectId, Current, Mean, Percentile66, Percentile33) :-
	project_iterations(ProjectId, Its),
	current_remaining_effort(ProjectId, Current),
	last(Its, Last), select(Last, Its, PreviousIts),
	maplist(total_remaining_effort, PreviousIts, Differences),
	mean(Differences, Mean),
	msort(Differences, Sorted),
	length(Differences, Length),
	percentile(Sorted, Length, 33, Percentile33),
	percentile(Sorted, Length, 66, Percentile66),
	!.

mean(Data, Mean) :-
	sumlist(Data, Sum),
	length(Data, Length),
	Mean is Sum / Length.

% TODO: refactor me!
percentile(SortedData, Length, Percentile, Value) :-
	integer((Percentile / 100) * Length) ->
	(
		Index is (Percentile / 100) * Length,
		include(=<(Index), SortedData, LessThan),
		length(LessThan, LLT),
		nth1(LLT, SortedData, LLTth),
		nth1(LLT+1, SortedData, LLT2th),
		Value is (LLTth + LLT2th) / 2, !
	);
	(
		Index is ceiling((Percentile / 100) * Length),
		include(>=(Index), SortedData, LessThan),
		length(LessThan, LLT),
		nth1(LLT, SortedData, Value)
	).

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
			project_iteration(ProjectId, ItId),
			project_task(ProjectId, TaskId),
			task_update(UpdateId, TaskId, When, _, _),
			When >= Start, When =< End),
		UpdateIds
	).

iteration_updates(ItId, When, UpdateIds) :-
	iteration(ItId, _, _),
	findall(UpdateId, (
			project_iteration(ProjectId, ItId),
			project_task(ProjectId, TaskId),
			task_update(UpdateId, TaskId, When, _, _)),
		UpdateIds
	).

latest_iteration(ProjectId, ItId, Start, End) :-
	project_iteration(ProjectId, ItId),
	iteration(ItId, Start, End),
	\+ (
		project_iteration(ProjectId, ItId2),
		iteration(ItId2, _, End2),
		ItId \= ItId2, End < End2
	).

latest_updates(ItId, UpdateIds) :-
	iteration_updates(ItId, AllUpdates),
	findall(UpdateId, (
		task_update(UpdateId, TaskId, When, _, _),
		member(UpdateId, AllUpdates),
		\+ (
			task_update(UpdateId2, TaskId, When2, _, _),
			member(UpdateId2, AllUpdates),
			UpdateId \= UpdateId2, When < When2
		)
	), UpdateIds).

current_remaining_effort(ProjectId, Current) :-
	latest_iteration(ProjectId, ItId, _, _),
	total_remaining_effort(ItId, Current).

collect_initial_estimations(ItId, UpdateIds, When, InitialEstimations) :-
	iteration(ItId, _, _),
	project_iteration(ProjectId, ItId),
	findall(InitialEstimation, (
		project_task(ProjectId, TaskId),
		task_update(UpdateId, TaskId, When, InitialEstimation, _),
		member(UpdateId, UpdateIds)
	), InitialEstimations).

collect_remaining_effort(ItId, UpdateIds, When, RemainingEfforts) :-
	iteration(ItId, _, _),
	project_iteration(ProjectId, ItId),
	findall(Remaining, (
		project_task(ProjectId, TaskId),
		task_update(UpdateId, TaskId, When, _, Remaining),
		member(UpdateId, UpdateIds)
	), RemainingEfforts).

total_initial_estimation(ItId, TotInitialEstimation) :-
	iteration(ItId, Start, _),
	collect_initial_estimations(ItId, Start, InitialEstimations),
	sumlist(InitialEstimations, TotInitialEstimation).

total_remaining_effort(ItId, TotRemainingEffort) :-
	latest_updates(ItId, UpdateIds),
	collect_remaining_effort(ItId, UpdateIds, _, RemainingEfforts),
	sumlist(RemainingEfforts, TotRemainingEffort).

iteration_day_difference(ItId, ItDay, When, Difference) :-
	iteration(ItId, _, _),
	project_iteration(ProjectId, ItId),
	project(ProjectId, _, _, _, Size, _),
	iteration_updates(ItId, When, UpdateIds),
	collect_initial_estimations(ItId, UpdateIds, When, InitialEstimations),
	collect_remaining_effort(ItId, UpdateIds, When, Remainings),
	sumlist(InitialEstimations, TotEstimation),
	sumlist(Remainings, TotRemaining),
	IdealRemaining is TotEstimation - ItDay * (TotEstimation / (Size - 1)),
	Difference is IdealRemaining - TotRemaining.

iteration_days(ItId, Days) :-
	iteration(ItId, Start, _),
	project_iteration(ProjectId, ItId),
	project(ProjectId, _, _, _, Ndays, _),
	iteration_days([], Start, Ndays, Days).
iteration_days(Days, _, Ndays, Days) :- length(Days, Ndays), !.
iteration_days(Acc, Day, Ndays, Days) :-
	append(Acc, [Day], NewAcc),
	NextDay is Day + 86400,
	iteration_days(NewAcc, NextDay, Ndays, Days).
