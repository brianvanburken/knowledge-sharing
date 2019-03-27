defmodule Solution do
  # iex --name foo@10.31.1.161 --cookie AVISI-8SGCHH80DTK80ICD7UI1
  # iex> import_file("solution.ex")
  # iex> server = :"challenge5@10.31.1.161"
  # iex> Node.connect(server)
  # iex> pid = Node.spawn(server, fn -> Challenge5.secret() end)
  # iex> watcher = spawn(Solution, :watch, [])
  # iex> for n <- 0..25 do
  # ...>   send(pid, {n, watcher})
  # ...> end

  def watch(), do: watch("")
  def watch(key) do
    receive do
      {:ok, letter} ->
        new_key = key <> letter
        IO.puts("Key so far: " <> new_key)
        watch(new_key)
      msg ->
        IO.inspect(msg)
        watch(key)
    end
  end
end
