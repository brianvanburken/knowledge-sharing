defmodule Solution do
  def watch(pid), do: watch(pid, "")
  def watch(pid, str) do
    receive do
      {:ok, letter, _} ->
        key = str <> letter
        if String.length(key) == 20 do
          IO.puts("Sending final key: " <> key)
          IO.inspect(self())
          send(pid, {key, self()})
        else
          IO.puts("Got another piece. Key so far: " <> key)
        end
        IO.puts("Waiting for another message")
        watch(pid, key)
      {:done, final} ->
        IO.puts("Got final message: " <> final)
        IO.puts(decode(final) <> decode(str))
      msg ->
        IO.inspect(msg)
        watch(pid, str)
    end
  end

  def decode(string) do
    array_of_emojis = String.graphemes(string)
    for emoji <- array_of_emojis,
      into: "",
      do: to_ascii(emoji)
  end

  def encode(string) do
    array_of_ascii = String.graphemes(string)
    for ascii <- array_of_ascii,
      into: "",
      do: to_emoji(ascii)
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
