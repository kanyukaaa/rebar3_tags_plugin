-module(rebar3_tags_plugin).

-export([init/1]).

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
  {ok, State1} = rebar3_tags_plugin_prv:init(State),
  {ok, State1}.
