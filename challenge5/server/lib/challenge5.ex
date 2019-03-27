defmodule Challenge5 do

  def secret do
    key = "AVISI-8SGCHH80DTK80ICD7UI1"
    len = String.length(key) - 1
    receive do
      {n, client} ->
        :timer.sleep(1000 * 2)
        if n > len do
          send(client, {:error, "You can't ask a position past the length of the key."})
        else
          part = String.at(key, n)
          send(client, {:ok, part})
        end
      {_, client} -> send(client, {:error, "Something went wrong. Do you want a position in the key?"})
    end
    secret()
  end
end
