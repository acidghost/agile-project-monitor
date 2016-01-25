:- use_module(monitoring).

% Testing facts
:-	date_time_stamp(date(2006,7,14,0,0,0,0,-,-), Start),
	date_time_stamp(date(2006,7,27,0,0,0,0,-,-), End),
	assert_project(1, "New Project", Start, End).

:-	date_time_stamp(date(2006,7,14,0,0,0,0,-,-), Start),
	date_time_stamp(date(2006,7,20,0,0,0,0,-,-), End),
	assert_iteration(1, Start, End).
:-	date_time_stamp(date(2006,7,21,0,0,0,0,-,-), Start),
	date_time_stamp(date(2006,7,27,0,0,0,0,-,-), End),
	assert_iteration(2, Start, End).

% Day 1
:-	date_time_stamp(date(2006,7,14,0,0,0,0,-,-), Stamp),
	assert(task(1, "Logging", 10, 0, Stamp)).
:-	date_time_stamp(date(2006,7,14,0,0,0,0,-,-), Stamp),
	assert(task(2, "Marketing", 7, 0, Stamp)).
:-	date_time_stamp(date(2006,7,14,0,0,0,0,-,-), Stamp),
	assert(task(3, "Developing", 13, 0, Stamp)).

% Day 2
:-	date_time_stamp(date(2006,7,15,0,0,0,0,-,-), Stamp),
	assert(task(1, "Logging", 10, 2, Stamp)).
:-	date_time_stamp(date(2006,7,15,0,0,0,0,-,-), Stamp),
	assert(task(2, "Marketing", 7, 3, Stamp)).
:-	date_time_stamp(date(2006,7,15,0,0,0,0,-,-), Stamp),
	assert(task(3, "Developing", 13, 3, Stamp)).

% Day 3
:-	date_time_stamp(date(2006,7,16,0,0,0,0,-,-), Stamp),
	assert(task(1, "Logging", 10, 5, Stamp)).
:-	date_time_stamp(date(2006,7,16,0,0,0,0,-,-), Stamp),
	assert(task(2, "Marketing", 7, 5, Stamp)).
:-	date_time_stamp(date(2006,7,16,0,0,0,0,-,-), Stamp),
	assert(task(3, "Developing", 13, 6, Stamp)).

%Day 4
:-	date_time_stamp(date(2006,7,17,0,0,0,0,-,-), Stamp),
	assert(task(1, "Logging", 10, 8, Stamp)).
:-	date_time_stamp(date(2006,7,17,0,0,0,0,-,-), Stamp),
	assert(task(2, "Marketing", 7, 7, Stamp)).
:-	date_time_stamp(date(2006,7,17,0,0,0,0,-,-), Stamp),
	assert(task(3, "Developing", 13, 7, Stamp)).

% Day 5
:-	date_time_stamp(date(2006,7,18,0,0,0,0,-,-), Stamp),
	assert(task(1, "Logging", 10, 10, Stamp)).
:-	date_time_stamp(date(2006,7,18,0,0,0,0,-,-), Stamp),
	assert(task(3, "Developing", 13, 8, Stamp)).

% Day 6
:-	date_time_stamp(date(2006,7,19,0,0,0,0,-,-), Stamp),
	assert(task(3, "Developing", 13, 10, Stamp)).

% Day 7
:-	date_time_stamp(date(2006,7,20,0,0,0,0,-,-), Stamp),
	assert(task(3, "Developing", 13, 11, Stamp)).

% Add to iteration
:-	foreach(
		task(Id, Name, Est, Done, Time),
		iteration_task(1, task(Id, Name, Est, Done, Time))
	).

% Add to project
:-	foreach(
		iteration(Id, Start, End, Tasks),
		project_iteration(1, _, iteration(Id, Start, End, Tasks))
	).
