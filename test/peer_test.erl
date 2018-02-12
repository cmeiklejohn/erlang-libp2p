-module(peer_test).

-include_lib("eunit/include/eunit.hrl").

info_test() ->
    Info1 = libp2p_peer:info_new("/ip4/1.2.3.4/tcp/4000/p2p/QmcgpsyWgH8Y8ajJz1Cu72KnS5uo2Aa2LpzU7kinSupNKC"),
    Info2 = libp2p_peer:info_new("QmcgpsyWgH8Y8ajJz1Cu72KnS5uo2Aa2LpzU7kinSupNKC", ["/ip4/1.2.3.4/tcp/4000"]),
    ?assertEqual(Info1, Info2),

    ?assertEqual(["/ip4/1.2.3.4/tcp/4000"], libp2p_peer:info_addrs(Info1)),
    ?assertEqual("QmcgpsyWgH8Y8ajJz1Cu72KnS5uo2Aa2LpzU7kinSupNKC", libp2p_peer:info_id(Info1)),

    ?assertError(bad_arg, libp2p_peer:info_new("/ip4/1.2.3.4/tcp/4000")),

    ok.
