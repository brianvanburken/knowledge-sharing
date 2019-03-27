defmodule Solution do
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
