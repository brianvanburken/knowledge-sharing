# Challenge4

```
elixir --name foo@<ip> --cookie <key> -S mix run -e "Challenge4.loop()" --no-halt
```

```
iex --name bar@<ip> --cookie <key>

iex> Node.connect(:"foo@<ip>")
iex> Node.list()
iex> pid = Node.spawn(:"foo@<ip>", fn ->
...>   Challenge4.loop()
...> end)
iex> send(pid, {:secret, self()})
```
