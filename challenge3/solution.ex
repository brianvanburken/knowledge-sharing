defmodule Solution do
  def parse(file_name) do
    case File.read(file_name) do
      {:ok, contents} ->
        <<
        _::binary-size(54),
        d::binary-size(7),
        _::binary-size(2),
        e::binary-size(4),
        _::binary-size(2),
        g::binary-size(4),
        _::binary-size(30),
        f::binary-size(2),
        _::binary-size(30),
        a::binary-size(5),
        _::binary-size(1),
        b::binary-size(1),
        _::binary-size(10),
        c::binary-size(3),
        _::binary-size(102)
        >> = contents

        a <> b <> c <> d <> e <> f <> g
    end
  end
end
