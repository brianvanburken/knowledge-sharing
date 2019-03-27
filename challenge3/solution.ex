defmodule Solution do
  def parse(file_name) do
    case File.read(file_name) do
      {:ok, contents} ->
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
          g::binary-size(3),
          _::binary>> = contents
        e <> f <> g <> a <> c <> b <> d
    end
  end
end
