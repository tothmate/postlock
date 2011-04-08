%%%-------------------------------------------------------------------
%%% File    : plObject.erl
%%% Author  : Peter Neumark <neumark@postlock.org>
%%% Description : A wrapper around the object type / state storage
%%% implementations. Use the plObject functions to call the correct
%%% code depending on the type of data.
%%%
%%% Created :  27 Mar 2011 by Peter Neumark <neumark@postlock.org>
%%%-------------------------------------------------------------------
-module(plObject).
-compile(export_all).
%%%-------------------------------------------------------------------
%%% Functions for dealing with object types.
%%%-------------------------------------------------------------------
new_obj(Mod, Oid) -> {Mod, apply(Mod, new_obj, [Oid])}.
get_oid({Mod, Obj}) -> apply(Mod, get_oid, [Obj]).
execute({Mod, Obj}, Cmd) -> {Mod, apply(Mod, execute, [Cmd, Obj])}.
%%%-------------------------------------------------------------------
%%% Functions for dealing with storage implementations.
%%%-------------------------------------------------------------------
new_state(Mod) -> {Mod, apply(Mod, new_state, [])}.
get_object(Oid, {Mod, State}) -> apply(Mod, get_object, [Oid, State]).
delete(Oid, {Mod, State}) -> {Mod, apply(Mod, delete, [Oid, State])}.
insert(Obj, {Mod, State}) -> {Mod, apply(Mod, insert, [Obj, State])}.
update(Obj, {Mod, State}) -> {Mod, apply(Mod, update, [Obj, State])}.
is_set(Oid, {Mod, State}) -> {Mod, apply(Mod, is_set, [Oid, State])}.
% only needed by ETS so far
destroy({Mod, State}) -> case erlang:function_exported(Mod, destroy, 1) of
        true -> apply(Mod, destroy, [State]);
        false -> noop
    end.
