defmodule Challenge2 do
  @moduledoc """
  Documentation for Challenge3.
  """

  @doc """
  Hello world.

  ## Examples

  iex> Challenge3.hello()
  :world

  Key: AVISI-d1JNeg

  """
  def parse() do
    <<_::binary-size(54),
      a::binary-size(1),
      _::binary-size(2),
      b::binary-size(1),
      _::binary-size(2),
      c::binary-size(1),
      _::binary-size(30),
      d::binary-size(3),
      _::binary-size(30),
      e::binary-size(2),
      _::binary-size(1),
      f::binary-size(1),
      _::binary-size(10),
      g::binary-size(2),
      _::binary>> = bin

    File.write!("./challenge2.bin", bin, [:binary])

    "" <> e <> f <> g <> "-" <> a <> c <> b <> d
  end

  def bin do
    random_string(54)
    <> "d" <> # A
    random_string(2)
    <> "J" <> # B
    random_string(2)
    <> "1" <> # C
    random_string(30)
    <> "Neg" <> # D
    random_string(30)
    <> "AV" <> # E
    random_string(1)
    <> "I" <> # F
    random_string(10)
    <> "SI" <> # G
    random_string(102)
  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64
    |> binary_part(0, length)
  end
end
end
