-module(rebar3_tags_plugin_prv).
-behaviour(provider).

-export([init/1, do/1, format_error/1]).

-define(PROVIDER, tags).
-define(DEPS, [app_discovery]).

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
  Provider = providers:create([{name, ?PROVIDER},            % The 'user friendly' name of the task
                               {module, ?MODULE},            % The module implementation of the task
                               {bare, true},                 % The task can be run by the user, always true
                               {deps, ?DEPS},                % The list of dependencies
                               {example, "rebar3 tags"},     % How to use the plugin
                               {opts, []},                   % list of options understood by the plugin
                               {short_desc, "Rebar3 plugin to generate a tags file"},
                               {desc, "Rebar3 plugin to generate a tags file"}]),
  {ok, rebar_state:add_provider(State, Provider)}.


-spec do(rebar_state:t()) -> {ok, rebar_state:t()} | {error, string()}.
do(State) ->
  Apps = case rebar_state:current_app(State) of
           undefined ->
             rebar_state:project_apps(State);
           App ->
             [App]
         end,
  tags:subdirs([filename:join(rebar_app_info:dir(App), "src") || App <- Apps]),
  {ok, State}.

-spec format_error(any()) ->  iolist().
format_error(Reason) ->
  io_lib:format("~p", [Reason]).
