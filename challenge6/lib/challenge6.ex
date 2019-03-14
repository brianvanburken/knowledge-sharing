defmodule Challenge6 do
  def secret() do
    secret_key = "AVISI-359GDSH249TNH9"
    secret_emoji = encode(secret_key)
    key = "YG595DG"
    key_emoji = encode(key)
    len = String.length(key_emoji) - 1
    receive do
      {^secret_emoji, ^key_emoji, client} ->
        send(client, {:message, encode("APPEND YOUR FETCHED KEY TO AVISI-")})
      {^secret_emoji, n, client} ->
        IO.inspect(client)
        :timer.sleep(1000 * 5)
        if n > len do
          send(client, {:error, "You can't ask a position past the length of the key."})
        else
          if n == len do
            part = String.at(key_emoji, n)
            send(client, {:done, part})
          else
            part = String.at(key_emoji, n)
            send(client, {:ok, part})
          end
        end
      {_, _, client} -> send(client, {:error, "Something went wrong. Did you send the correct key?"})
    end
    secret()
  end


  # elixir --name challenge6@10.31.1.161 --cookie AVISI-359GDSH249TNH9 -S mix run -e "Challenge6.secret()" --no-halt
  # iex --name bar@10.31.1.161 --cookie AVISI-359GDSH249TNH9

  # server = :"challenge6@10.31.1.161"
  # secret = "AVISI-359GDSH249TNH9"
  # secret_emoji = Challenge6.encode(secret)
  # true = Node.connect(server)
  # pid = Node.spawn(server, fn -> Challenge6.secret() end)
  # watcher = spawn(Challenge6, :watch, ["", secret_emoji, pid])
  # for n <- 0..6 do
  #   send(pid, {secret_emoji, n, watcher})
  # end
  #
  def watch(str, secret, pid) do
    receive do
      {:ok, letter} ->
        key = str <> letter
        IO.puts(key)
        watch(key, secret, pid)
      {:done, letter} ->
        key = str <> letter
        IO.puts(key)
        IO.puts(secret)
        send(pid, {secret, key, self()})
        watch(key, secret, pid)
      {:message, message} ->
        IO.puts( decode(message) <> decode(str) )
      msg ->
        IO.inspect(msg)
        watch(str, secret, pid)
    end
  end

  def decode(string) do
    string
    |> String.codepoints()
    |> Enum.map(&to_ascii/1)
    |> Enum.join()
  end

  def encode(string) do
    string
    |> String.codepoints()
    |> Enum.map(&to_emoji/1)
    |> Enum.join()
  end

  mapping = %{
    "😀" => "A",
    "😂" => "B",
    "😍" => "C",
    "😅" => "D",
    "😘" => "E",
    "😎" => "F",
    "🤓" => "G",
    "🤩" => "H",
    "😜" => "I",
    "😛" => "J",
    "🙂" => "K",
    "🙃" => "L",
    "😉" => "M",
    "😔" => "N",
    "😢" => "O",
    "🥺" => "P",
    "🤯" => "Q",
    "🤬" => "R",
    "😫" => "S",
    "😭" => "T",
    "😤" => "U",
    "😱" => "V",
    "🤔" => "W",
    "😓" => "X",
    "🤫" => "Y",
    "🤭" => "Z",
    "😴" => "0",
    "🤑" => "1",
    "😖" => "2",
    "😝" => "3",
    "🧐" => "4",
    "😙" => "5",
    "😌" => "6",
    "☺️" => "7",
    "😊" => "8",
    "😇" => "9",
    "🤕" => "-",
    "🙄" => " "
  }

  for { emoji, ascii } <- mapping do
    def to_ascii(unquote(emoji)), do: unquote(ascii)
    def to_emoji(unquote(ascii)), do: unquote(emoji)
  end
end
