defmodule Challenge4 do
  def loop do
    receive do
      {:secret, client} ->
        send(client, "Yes, you got it! Your key is: AVISI-85hsd715")
    end
    loop()
  end
end
