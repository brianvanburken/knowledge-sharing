defmodule Solution do
  # Start REPL with: iex --name foo@10.31.1.161 --cookie AVISI-359GDSH249TNH9
  #
  # iex> import_file("solution.ex")
  # iex> server = :"challenge6@10.31.1.161"
  # iex> Node.connect(server)
  # iex> pid = Node.spawn_link(server, fn -> Challenge6.secret() end)
  # iex> watcher = spawn_link(Solution, :watch, ["", pid])
  # iex> IO.inspect(watcher)
  # iex> for n <- 0..6 do
  # iex>   emoji_n = n |> Integer.to_string() |> Solution.encode()
  # iex>   send(pid, {emoji_n, watcher})
  # iex> end

  def watch(str, pid) do
    receive do
      {:ok, letter, _} ->
        key = str <> letter
        if String.length(key) == 7 do
          IO.puts("Sending final key: " <> key)
          IO.inspect(self())
          send(pid, {key, self()})
        else
          IO.puts("Got another piece. Key so far: " <> key)
        end
        IO.puts("Waiting for another message")
        watch(key, pid)
      {:done, final} ->
        IO.puts("Got final message: " <> final)
        IO.puts(decode(final) <> decode(str))
      msg ->
        IO.inspect(msg)
        watch(str, pid)
    end
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
