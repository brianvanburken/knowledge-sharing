defmodule Challenge4 do
  def secret do
    IO.puts("Starting listener")
    receive do
      {:secret, client} ->
        send(client, "Yes, you got it! Your key is: AVISI-NQ0LXKG00XSGEMUWLTZ5")
    end
    secret()
  end
end
