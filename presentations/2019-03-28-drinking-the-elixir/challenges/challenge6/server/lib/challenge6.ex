defmodule Challenge6 do
  # elixir --name challenge6@10.31.1.161 --cookie AVISI-8SGCHH80DTK80ICD7UI1 -S mix run -e "Challenge6.secret()" --no-halt
  def secret() do
    key = "7W9PQLDM6JHSIHSRXKC1"
    key_emoji = encode(key)
    len = String.length(key_emoji) - 1
    receive do
      {^key_emoji, client} ->
        send(client, {:done, encode("APPEND YOUR FETCHED KEY TO THIS STRING AVISI-")})
      {emoji_index, client} ->
        :timer.sleep(1000 * 2)
        emoji_index
        |> decode()
        |> Integer.parse()
        |> case do
          :error ->
            send(client, {:error, "You didn't send a valid integer value"})
          {n, _} ->
            if n > len do
              send(client, {:error, "You can't ask a position past the length of the key."})
            else
              part = String.at(key_emoji, n)
              send(client, {:ok, part, n})
            end
        end
      msg ->
        IO.inspect(msg)
    end
    secret()
  end

  def decode(string) do
    string
    |> String.graphemes()
    |> Enum.map(&to_ascii/1)
    |> Enum.join()
  end

  def encode(string) do
    string
    |> String.graphemes()
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
