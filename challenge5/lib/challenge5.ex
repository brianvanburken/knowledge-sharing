defmodule Challenge5 do
  def secret() do
    secret = "AVISI-85hsd715"
    key = "AVISI-359GDSH249TNH9"
    len = String.length(key) - 1
    receive do
      {n, client} ->
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
      {_, client} -> send(client, {:error, "Something went wrong. Do you want a position in the key?"})
    end
    secret()
  end


  # elixir --name challenge5@10.31.1.161 --cookie AVISI-85hsd715 -S mix run -e "Challenge5.secret()" --no-halt
  # iex --name bar@10.31.1.161 --cookie AVISI-85hsd715

  # def start() do
  #   server = :"challenge5@10.31.1.161"
  #   Node.connect(server)
  #   watcher = spawn(Challenge5, :watch, [pid])
  #   for n <- 0..19 do
  #     pid = Node.spawn(server, fn -> Challenge5.secret() end)
  #     send(pid, {n, watcher})
  #   end
  # end
  #
  # def watch(pid), do: watch(pid, "")
  # def watch(pid, str) do
  #   receive do
  #     {:ok, letter} ->
  #       watch(pid, str <> letter)
  #     {:done, letter} ->
  #       IO.inspect(str <> letter)
  #     msg ->
  #       IO.inspect(msg)
  #       watch(pid, str)
  #   end
  # end
end
