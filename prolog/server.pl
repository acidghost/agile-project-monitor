:- module(monitoring_server,
	[
		server/0,
		server/1				% ?Port
	]).

:- use_module(library(pengines)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).

server :- server(1337).

server(Port) :-
		http_server(http_dispatch,
					[ port(Port) ]).

:- pengine_application(monitoring).
:- use_module(monitoring:'./monitoring.pl').
