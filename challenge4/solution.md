# Solution

## Starting the remote node

```bash
export CHALLENGE4_COOKIE=AVISI-ZKSI88Y7TX6DOJSTI9ON && \
export CHALLENGE4_NAME=challenge4@10.31.1.161 && \
elixir \
--name $CHALLENGE4_NAME \
--cookie $CHALLENGE4_COOKIE \
--erl '-kernel inet_dist_listen_min 9000'  \
--erl '-kernel inet_dist_listen_max 9000' \
--no-halt \
-S mix run -e "Challenge4.secret()"
```

## Connection to the remote node

```bash
iex --name foo@10.31.1.161
```

```elixir
iex> server = :"challenge4@10.0.0.1"
iex> Node.set_cookie("AVISI-ZKSI88Y7TX6DOJSTI9ON")
iex> Node.connect(server)
iex> pid = Node.spawn(server, fn -> Challenge4.secret() end)
iex> send(pid, {:secret, self()})
iex> flush()
```
