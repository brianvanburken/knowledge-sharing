defmodule Challenge5 do
  def loop() do
    secret = "AVISI-85hsd715"
    key = "AVISI-359gdsh249tnh9"
    final_key = "AVISI-235hagy4"
    len = String.length(key) - 1
    receive do
      {^secret, ^key, client} ->
        IO.inspect(client)
        send(client, "Well done! Here is the final key: " <> final_key)
      {^secret, n, client} ->
        IO.inspect(client)
        # :timer.sleep(1000 * 10)
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
    loop()
  end


  # server = :"honey@10.31.1.161"
  # secret = "AVISI-85hsd715"
  # true = Node.connect(server)
  # pid = Node.spawn(server, fn -> Challenge5.loop() end)
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
