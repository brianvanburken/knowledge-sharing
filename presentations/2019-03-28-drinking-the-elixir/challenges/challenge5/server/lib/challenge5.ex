defmodule Challenge5 do

  def secret do
    key = "AVISI-8SGCHH80DTK80ICD7UI1"
    len = String.length(key) - 1
    receive do
      {n, client} ->
        :timer.sleep(1000 * 2)
        if not is_integer(n) do
          send(client, {:error, "You need to send it an integer position"})
        else
          if n > len do
            send(client, {:error, "You can't ask a position past the length of the key."})
          else
            part = String.at(key, n)
            send(client, {:ok, part})
          end
        end
    end
    secret()
  end
end
