-module(libp2p_peer).

-record(info, {
          id :: string(),
          addrs :: [string()]
         }).

-opaque info() :: #info{}.

-export_type([info/0]).
-export([info_new/1, info_new/2, info_id/1, info_addrs/1]).

-spec info_new(string(), [string()]) -> info().
info_new(ID, Addrs) ->
    #info{id=ID, addrs=Addrs}.

-spec info_new(string()) -> info().
info_new(P2PAddr) ->
    Protocols = multiaddr:protocols(multiaddr:new(P2PAddr)),
    case lists:keytake("p2p", 1, Protocols) of
        false -> error(bad_arg);
        {value, {"p2p", ID}, AddrProtos} ->
            info_new(ID, [multiaddr:to_string(AddrProtos)])
    end.

-spec info_id(info()) -> string().
info_id(#info{id=ID}) ->
    ID.

-spec info_addrs(info()) -> [string()].
info_addrs(#info{addrs=Addrs}) ->
    Addrs.
