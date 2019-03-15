defmodule Challenge1 do
  @doc """
  Decodes our secret emoji language to human-readable ASCII strings

  ## Examples

      iex> Challenge1.decode("😀😱😜😫😜")
      "AVISI"

  """
  def decode(string) do
    # Note: this uses Elixir pipes a concept not explained in the presentation
    string # start with our emoji string
    |> String.graphemems() # split string to an array of each emoji
    |> Enum.map(&to_ascii/1) # map each emoji to ASCII
    |> Enum.join() # join array of ASCII letters to a string
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
  end
end
