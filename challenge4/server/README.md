# Challenge 4

## Starting the remote node

You need to fetch the local IP using `ifconfig | grep 10.`

```bash
elixir --name challenge4@10.0.0.1 --cookie <key> -S mix run -e "Challenge4.secret()" --no-halt
```
