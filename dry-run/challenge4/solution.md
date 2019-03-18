# Solution

## Starting the remote node

You need to fetch the local IP using `ifconfig | grep 10.`

```bash
elixir --name challenge4@10.0.0.1 --cookie <key> -S mix run -e "Challenge4.secret()" --no-halt
```

## Connection to the remote node

```bash
iex --name foo@10.0.0.2 --cookie <key>
```

## Getting the key

```elixir
iex> server = :"challenge4@10.0.0.1"
iex> Node.connect(server)
iex> pid = Node.spawn(server, fn -> Challenge4.secret() end)
iex> send(pid, {:secret, self()})
iex> flush()
```
