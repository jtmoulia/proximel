# Proximel

^ because it's built on
[distel](https://github.com/massemanet/distel). Get it!?

Proximel is a hopefully simple and powerful example of implementing
elixir tooling in emacs using distel. Distel provides a powerful, mature
RPC interface that works great with elixir right out of the box:

```elisp
(erl-send-rpc node 'Elixir.Enum 'count '(1 2 3))
```

This repo includes examples of:

- Loading an elixir(/any beam) module into a running node
- A [company-mode](http://company-mode.github.io/) autocomplete
  backend

## Usage

You're going to need to have distel installed.

From a shell, boot an erlang virtual machine with a distributed erlang
node name. Include `-S mix` if it's an interactive shell for a mix
project:

```shell
$ iex --name proximel@127.0.0.1 [-S mix]
```

From emacs call the interactive function `proximel-load-modules`, and
enter `proximel@127.0.0.1` (or whoever you are) as the node name. Now
the erlang node is talking with emacs as if it's just another node.
As a bonus, it loaded our Erlang bytecode into it. Blows my mind.

The compay-mode backend, `proximel-company` is a rough example of
autocomplete. The benefits are that it's snappy, and you can choose
the node which is running autocompletion.

It is not added to the `company-backends` list by default because it
might cause performance issues at the moment. You can add it to the
list via `(add-to-list 'company-backends 'proximel-company)`. To force
it's usage you can wipe out the list
`(setq company-backends '(proximel-company))`.
