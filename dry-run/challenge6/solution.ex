defmodule Solution do
  # server = :"challenge6@10.31.1.161"
  # secret = "AVISI-359GDSH249TNH9"
  # secret_emoji = Solution.encode(secret)
  # Node.connect(server)
  # pid = Node.spawn_link(server, fn -> Challenge6.secret() end)
  # watcher = spawn_link(Solution, :watch, ["", secret_emoji, pid])
  # for n <- 0..7 do
  #   send(pid, {secret_emoji, n, watcher})
  # end

  def watch(str, secret, pid) do
    receive do
      {:ok, letter, _} ->
        key = str <> letter
        watch(key, secret, pid)
      {:done, letter, _} ->
        key = str <> letter
        IO.puts(key)
        IO.puts(secret)
        send(pid, {secret, encode(key), self()})
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
