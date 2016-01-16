#!/usr/bin/env swipl

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Script to start the SWI-Prolog server as a Unix daemon process
based on library(http/http_unix_daemon). The server is started as a
deamon using
  % ./daemon.pl port=Port [option ...]
See library(http/http_unix_daemon) for details. Using ./deamon.pl --help
for a brief help message.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

:- set_prolog_flag(verbose, silent).
:- use_module(library(http/http_unix_daemon)).
%% :- use_module(library(broadcast)).
:- use_module(server).

% http_daemon/0 processes the commandline options, creates the requested
% daemon setup and starts the HTTP server.

:- initialization http_daemon.
