-module(libp2p_connection).

-record(connection, {
          module :: module(),
          state :: any()
         }).

-type connection() :: #connection{}.

-export_type([connection/0]).

-export([new/2, send/2, recv/2, recv/3, acknowledge/2, set_options/2, close/1]).

-callback acknowledge(any(), reference()) -> ok.
-callback send(any(), iodata()) -> ok | {error, term()}.
-callback recv(any(), non_neg_integer(), pos_integer()) -> binary() | {error, term()}.
-callback close(any()) -> ok.
-callback set_options(any(), any()) -> ok | {error, term()}.

-define(RECV_TIMEOUT, 5000).

-spec new(atom(), any()) -> connection().
new(Module, State) ->
    #connection{module=Module, state=State}.


-spec send(connection(), iodata()) -> ok | {error, term()}.
send(#connection{module=Module, state=State}, Data) ->
    Module:send(State, Data).

-spec recv(connection(), non_neg_integer()) -> binary() | {error, term()}.
recv(Conn=#connection{}, Length) ->
    recv(Conn, Length, ?RECV_TIMEOUT).

-spec recv(connection(), non_neg_integer(), pos_integer()) -> binary() | {error, term()}.
recv(#connection{module=Module, state=State}, Length, Timeout) ->
    Module:recv(State, Length, Timeout).

-spec acknowledge(connection(), reference()) -> ok.
acknowledge(#connection{module=Module, state=State}, Ref) ->
    Module:acknowledge(State, Ref).

-spec close(connection()) -> ok.
close(#connection{module=Module, state=State}) ->
    Module:close(State).

-spec set_options(connection(), any()) -> ok | {error, term()}.
set_options(#connection{module=Module, state=State}, Options) ->
    Module:set_options(State, Options).
