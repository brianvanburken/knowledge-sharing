defmodule Challenge5 do
  def secret() do
    secret = "AVISI-85hsd715"
    key = "AVISI-359GDSH249TNH9"
    len = String.length(key) - 1
    receive do
      {^secret, n, client} ->
        IO.inspect(client)
        :timer.sleep(1000 * 5)
        if n > len do
          send(client, {:error, "You can't ask a position past the length of the key."})
        else
          if n == len do
            part = String.at(key, n)
            send(client, {:done, part})
          else
            part = String.at(key, n)
            send(client, {:ok, part})
          end
        end
      {_, _, client} -> send(client, {:error, "Something went wrong. Did you send the correct key?"})
    end
    secret()
  end


  # elixir --name challenge5@10.31.1.161 --cookie AVISI-85hsd715 -S mix run -e "Challenge5.secret()" --no-halt
  # iex --name bar@10.31.1.161 --cookie AVISI-85hsd715

  # server = :"challenge5@10.31.1.161"
  # secret = "AVISI-85hsd715"
  # true = Node.connect(server)
  # pid = Node.spawn(server, fn -> Challenge5.secret() end)
  # watcher = spawn(Challenge5, :watch, ["", secret, pid])
  # for n <- 0..19 do
  #   send(pid, {secret, n, watcher})
  # end
  #
  # def watch(str, secret, pid) do
  #   receive do
  #     {:ok, letter} ->
  #       key = str <> letter
  #       watch(key, secret, pid)
  #     {:done, letter} ->
  #       key = str <> letter
  #       IO.puts(key)
  #       send(pid, {secret, key, self()})
  #       watch(key, secret, pid)
  #     msg ->
  #       IO.puts(msg)
  #       watch(str, secret, pid)
  #   end
  # end
end
