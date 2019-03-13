defmodule Challenge5 do
  def loop() do
    secret = "AVISI-85hsd715"
    key = "AVISI-359gdsh249tnh9"
    final_key = "AVISI-235hagy4"
    len = String.length(key) - 1
    receive do
      {^secret, ^key, client} ->
        send(client, "Well done! Here is the final key: " <> final_key)
      {^secret, n, client} ->
        :timer.sleep(1000 * 10)
        if n > len do
          send(client, {:error, "You can't ask a position past the length of the key."}
        else
          part = String.at(key, n)
          send(client, {:ok, part})
        end
      {_, _, client} -> send(client, {:error, "Something went wrong. Did you send the correct key?"}
      _ -> send(client, {:error, "Something went wrong. Did you send the correct message?"}
    end
    loop()
  end
end
