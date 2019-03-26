defmodule Solution do
  # iex --name foo@10.31.1.161 --cookie AVISI-85hsd715
  # iex> server = :"challenge5@10.0.0.1"
  # iex> Node.connect(server)
  # iex> watcher = spawn(Solution, :watch, [pid, ""])
  # iex> pid = Node.spawn(server, fn -> Challenge5.secret() end)
  # iex> for n <- 0..19 do
  # iex>   send(pid, {n, watcher})
  # iex> end

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
