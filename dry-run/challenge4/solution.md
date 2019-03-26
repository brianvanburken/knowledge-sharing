# Solution

## Starting the remote node

```bash
export CHALLENGE4_KEY=key && \
export CHALLENGE4_NAME=challenge4@10.31.1.161 && \
elixir --name $CHALLENGE4_NAME --cookie $CHALLENGE4_KEY -S mix run -e "Challenge4.secret()" --no-halt
```

## Connection to the remote node

```bash
iex --name foo@10.31.1.161 --cookie key
```

## Getting the key

```elixir
iex> server = :"challenge4@10.0.0.1"
iex> Node.connect(server)
iex> pid = Node.spawn(server, fn -> Challenge4.secret() end)
iex> send(pid, {:secret, self()})
iex> flush()
```
