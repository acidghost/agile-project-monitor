:- use_module(monitoring).

% PROJECT 1
:- 	date_time_stamp(date(2006,7,14,0,0,0,0,-,-), Start),
	date_time_stamp(date(2007,7,13,0,0,0,0,-,-), End),
	assert(project(1, "Project One", Start, End, 7, man_effort)).

% SPRINT 1
:- 	date_time_stamp(date(2006,7,14,0,0,0,0,-,-), Start),
	date_time_stamp(date(2006,7,20,0,0,0,0,-,-), End),
	assert(iteration(1, Start, End)),
	assert(project_iteration(1, 1)).

% NEW TASKS FOR SPRINT 1
:-	assert(task(1, "New Feature", "Cool feature story", [])),
	assert(project_task(1, 1)),
	assert(task(2, "New Feature 2", "Cool feature story", [])),
	assert(project_task(1, 2)),
	assert(task(3, "New Feature 3", "Cool feature story", [])),
	assert(project_task(1, 3)),
	assert(task(4, "New Feature 4", "Cool feature story", [])),
	assert(project_task(1, 4)).

% TASK UPDATES FOR SPRINT 1
:- 	date_time_stamp(date(2006,7,14,0,0,0,0,-,-), When1),
	assert(task_update(1, 1, When1, 6, 5)),
	date_time_stamp(date(2006,7,15,0,0,0,0,-,-), When2),
	assert(task_update(2, 1, When2, 6, 5)),
	date_time_stamp(date(2006,7,16,0,0,0,0,-,-), When3),
	assert(task_update(3, 1, When3, 6, 4)),
	date_time_stamp(date(2006,7,17,0,0,0,0,-,-), When4),
	assert(task_update(4, 1, When4, 6, 2)),
	date_time_stamp(date(2006,7,18,0,0,0,0,-,-), When5),
	assert(task_update(5, 1, When5, 6, 0)).

:- 	date_time_stamp(date(2006,7,14,0,0,0,0,-,-), When1),
	assert(task_update(6, 2, When1, 4, 4)),
	date_time_stamp(date(2006,7,15,0,0,0,0,-,-), When2),
	assert(task_update(7, 2, When2, 4, 4)),
	date_time_stamp(date(2006,7,16,0,0,0,0,-,-), When3),
	assert(task_update(8, 2, When3, 4, 2)),
	date_time_stamp(date(2006,7,17,0,0,0,0,-,-), When4),
	assert(task_update(9, 2, When4, 4, 1)),
	date_time_stamp(date(2006,7,18,0,0,0,0,-,-), When5),
	assert(task_update(10, 2, When5, 4, 0)).

:- 	date_time_stamp(date(2006,7,14,0,0,0,0,-,-), When1),
	assert(task_update(11, 3, When1, 10, 10)),
	date_time_stamp(date(2006,7,15,0,0,0,0,-,-), When2),
	assert(task_update(12, 3, When2, 10, 9)),
	date_time_stamp(date(2006,7,16,0,0,0,0,-,-), When3),
	assert(task_update(13, 3, When3, 10, 7)),
	date_time_stamp(date(2006,7,17,0,0,0,0,-,-), When4),
	assert(task_update(14, 3, When4, 10, 6)),
	date_time_stamp(date(2006,7,18,0,0,0,0,-,-), When5),
	assert(task_update(15, 3, When5, 10, 6)),
	date_time_stamp(date(2006,7,19,0,0,0,0,-,-), When6),
	assert(task_update(16, 3, When6, 10, 3)),
	date_time_stamp(date(2006,7,20,0,0,0,0,-,-), When7),
	assert(task_update(17, 3, When7, 10, 2)).

:- 	date_time_stamp(date(2006,7,14,0,0,0,0,-,-), When1),
	assert(task_update(18, 4, When1, 8, 7)),
	date_time_stamp(date(2006,7,15,0,0,0,0,-,-), When2),
	assert(task_update(19, 4, When2, 8, 6)),
	date_time_stamp(date(2006,7,16,0,0,0,0,-,-), When3),
	assert(task_update(20, 4, When3, 8, 7)),
	date_time_stamp(date(2006,7,17,0,0,0,0,-,-), When4),
	assert(task_update(21, 4, When4, 8, 6)),
	date_time_stamp(date(2006,7,18,0,0,0,0,-,-), When5),
	assert(task_update(22, 4, When5, 8, 5)),
	date_time_stamp(date(2006,7,19,0,0,0,0,-,-), When6),
	assert(task_update(23, 4, When6, 8, 3)),
	date_time_stamp(date(2006,7,20,0,0,0,0,-,-), When7),
	assert(task_update(24, 4, When7, 8, 1)).

% SPRINT 2
:- 	date_time_stamp(date(2006,7,21,0,0,0,0,-,-), Start),
	date_time_stamp(date(2006,7,27,0,0,0,0,-,-), End),
	assert(iteration(2, Start, End)),
	assert(project_iteration(1, 2)).

% NEW TASKS FOR SPRINT 2
:-	assert(task(5, "New Feature 5", "Cool feature story", [])),
	assert(project_task(1, 5)),
	assert(task(6, "New Feature 6", "Cool feature story", [])),
	assert(project_task(1, 6)),
	assert(task(7, "New Feature 7", "Cool feature story", [])),
	assert(project_task(1, 7)).

% TASK UPDATES FOR SPRINT 2
:- 	date_time_stamp(date(2006,7,21,0,0,0,0,-,-), When1),
	assert(task_update(25, 3, When1, 2, 0)),
	date_time_stamp(date(2006,7,21,0,0,0,0,-,-), When2),
	assert(task_update(26, 4, When2, 1, 0)).

:- 	date_time_stamp(date(2006,7,21,0,0,0,0,-,-), When1),
	assert(task_update(27, 5, When1, 10, 9)),
	date_time_stamp(date(2006,7,22,0,0,0,0,-,-), When2),
	assert(task_update(28, 5, When2, 10, 8)),
	date_time_stamp(date(2006,7,23,0,0,0,0,-,-), When3),
	assert(task_update(29, 5, When3, 10, 7)),
	date_time_stamp(date(2006,7,24,0,0,0,0,-,-), When4),
	assert(task_update(30, 5, When4, 10, 6)),
	date_time_stamp(date(2006,7,25,0,0,0,0,-,-), When5),
	assert(task_update(31, 5, When5, 10, 2)),
	date_time_stamp(date(2006,7,26,0,0,0,0,-,-), When6),
	assert(task_update(32, 5, When6, 10, 1)),
	date_time_stamp(date(2006,7,27,0,0,0,0,-,-), When7),
	assert(task_update(33, 5, When7, 10, 0)).

:- 	date_time_stamp(date(2006,7,21,0,0,0,0,-,-), When1),
	assert(task_update(34, 6, When1, 6, 6)),
	date_time_stamp(date(2006,7,22,0,0,0,0,-,-), When2),
	assert(task_update(35, 6, When2, 6, 5)),
	date_time_stamp(date(2006,7,23,0,0,0,0,-,-), When3),
	assert(task_update(36, 6, When3, 6, 2)),
	date_time_stamp(date(2006,7,24,0,0,0,0,-,-), When4),
	assert(task_update(37, 6, When4, 6, 0)).

:- 	date_time_stamp(date(2006,7,21,0,0,0,0,-,-), When1),
	assert(task_update(38, 7, When1, 6, 6)),
	date_time_stamp(date(2006,7,22,0,0,0,0,-,-), When2),
	assert(task_update(39, 7, When2, 6, 5)),
	date_time_stamp(date(2006,7,23,0,0,0,0,-,-), When3),
	assert(task_update(40, 7, When3, 6, 4)),
	date_time_stamp(date(2006,7,24,0,0,0,0,-,-), When4),
	assert(task_update(41, 7, When4, 6, 3)),
	date_time_stamp(date(2006,7,25,0,0,0,0,-,-), When5),
	assert(task_update(42, 7, When5, 6, 2)),
	date_time_stamp(date(2006,7,26,0,0,0,0,-,-), When6),
	assert(task_update(43, 7, When6, 6, 1)),
	date_time_stamp(date(2006,7,27,0,0,0,0,-,-), When7),
	assert(task_update(44, 7, When7, 6, 0)).

% SPRINT 3
:- 	date_time_stamp(date(2006,7,28,0,0,0,0,-,-), Start),
	date_time_stamp(date(2006,8,3,0,0,0,0,-,-), End),
	assert(iteration(3, Start, End)),
	assert(project_iteration(1, 3)).

% NEW TASKS FOR SPRINT 3
:-	assert(task(8, "New Feature 8", "Cool feature story", [])),
	assert(project_task(1, 8)),
	assert(task(9, "New Feature 9", "Cool feature story", [])),
	assert(project_task(1, 9)),
	assert(task(10, "New Feature 10", "Cool feature story", [])),
	assert(project_task(1, 10)),
	assert(task(11, "New Feature 11", "Cool feature story", [])),
	assert(project_task(1, 11)).

% TASK UPDATES FOR SPRINT 3
:- 	date_time_stamp(date(2006,7,28,0,0,0,0,-,-), When1),
	assert(task_update(45, 8, When1, 10, 9)),
	date_time_stamp(date(2006,7,29,0,0,0,0,-,-), When2),
	assert(task_update(46, 8, When2, 10, 8)),
	date_time_stamp(date(2006,7,30,0,0,0,0,-,-), When3),
	assert(task_update(47, 8, When3, 10, 7)),
	date_time_stamp(date(2006,7,31,0,0,0,0,-,-), When4),
	assert(task_update(48, 8, When4, 10, 6)),
	date_time_stamp(date(2006,8,1,0,0,0,0,-,-), When5),
	assert(task_update(49, 8, When5, 10, 4)),
	date_time_stamp(date(2006,8,2,0,0,0,0,-,-), When6),
	assert(task_update(50, 8, When6, 10, 3)),
	date_time_stamp(date(2006,8,3,0,0,0,0,-,-), When7),
	assert(task_update(51, 8, When7, 10, 1)).

:- 	date_time_stamp(date(2006,7,28,0,0,0,0,-,-), When1),
	assert(task_update(52, 9, When1, 7, 6)),
	date_time_stamp(date(2006,7,29,0,0,0,0,-,-), When2),
	assert(task_update(53, 9, When2, 7, 6)),
	date_time_stamp(date(2006,7,30,0,0,0,0,-,-), When3),
	assert(task_update(54, 9, When3, 7, 5)),
	date_time_stamp(date(2006,7,31,0,0,0,0,-,-), When4),
	assert(task_update(55, 9, When4, 7, 2)),
	date_time_stamp(date(2006,8,1,0,0,0,0,-,-), When5),
	assert(task_update(56, 9, When5, 7, 2)),
	date_time_stamp(date(2006,8,2,0,0,0,0,-,-), When6),
	assert(task_update(57, 9, When6, 7, 0)).

:-	date_time_stamp(date(2006,7,28,0,0,0,0,-,-), When1),
	assert(task_update(58, 10, When1, 4, 3)),
	date_time_stamp(date(2006,7,29,0,0,0,0,-,-), When2),
	assert(task_update(59, 10, When2, 4, 2)),
	date_time_stamp(date(2006,7,30,0,0,0,0,-,-), When3),
	assert(task_update(60, 10, When3, 4, 1)),
	date_time_stamp(date(2006,7,31,0,0,0,0,-,-), When4),
	assert(task_update(61, 10, When4, 4, 0)).

:- 	date_time_stamp(date(2006,7,28,0,0,0,0,-,-), When1),
	assert(task_update(62, 11, When1, 12, 12)),
	date_time_stamp(date(2006,7,29,0,0,0,0,-,-), When2),
	assert(task_update(63, 11, When2, 12, 11)),
	date_time_stamp(date(2006,7,30,0,0,0,0,-,-), When3),
	assert(task_update(64, 11, When3, 12, 10)),
	date_time_stamp(date(2006,7,31,0,0,0,0,-,-), When4),
	assert(task_update(65, 11, When4, 12, 8)),
	date_time_stamp(date(2006,8,1,0,0,0,0,-,-), When5),
	assert(task_update(66, 11, When5, 12, 6)),
	date_time_stamp(date(2006,8,2,0,0,0,0,-,-), When6),
	assert(task_update(67, 11, When6, 12, 5)),
	date_time_stamp(date(2006,8,3,0,0,0,0,-,-), When7),
	assert(task_update(68, 11, When7, 12, 4)).
