defmodule Challenge4 do
  # Node.connect(:"challenge4@10.31.1.161")
  # elixir --name challenge4@10.31.1.161 --cookie AVISI-74gF03hT -S mix run -e "Challenge4.secret()" --no-halt
  #
  #
  # iex --name foo@10.31.1.161 --cookie AVISI-74gF03hT
  # iex(foo@10.31.1.161)2> Node.spawn(:"challenge4@10.31.1.161", fn -> Challenge4.secret() end)
  # iex(foo@10.31.1.161)3> pid = Node.spawn(:"challenge4@10.31.1.161", fn -> Challenge4.secret() end)
  # iex(foo@10.31.1.161)4> send(pid, {:secret, self()})
  # iex(foo@10.31.1.161)5> flush()
  def secret do
    IO.puts("Starting listener")
    receive do
      {:secret, client} ->
        send(client, "Yes, you got it! Your key is: AVISI-85hsd715")
    end
    secret()
  end
end
