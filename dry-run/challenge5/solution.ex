defmodule Challenge5 do
  # server = :"challenge5@10.0.0.1"
  def start(server) do
    Node.connect(server)
    watcher = spawn(Challenge5, :watch, [pid, ""])
    for n <- 0..19 do
      pid = Node.spawn(server, fn -> Challenge5.secret() end)
      send(pid, {n, watcher})
    end
  end

  def watch(pid, str) do
    receive do
      {:ok, letter} ->
        IO.inspect(str <> letter)
        watch(pid, str <> letter)
      msg ->
        IO.inspect(msg)
        watch(pid, str)
    end
  end
end
