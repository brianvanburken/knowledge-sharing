defmodule Solution do
  # server = :"challenge5@10.0.0.1"
  # Node.connect(server)
  # watcher = spawn(Solution, :watch, [pid, ""])
  # pid = Node.spawn(server, fn -> Challenge5.secret() end)
  # for n <- 0..19 do
  #   send(pid, {n, watcher})
  # end

  def watch(pid, str) do
    receive do
      {:ok, letter, _} ->
        IO.inspect(str <> letter)
        watch(pid, str <> letter)
      msg ->
        IO.inspect(msg)
        watch(pid, str)
    end
  end
end
