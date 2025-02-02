defmodule Solution do
    def repair(file_name) do
    case File.read(file_name) do
      {:ok, contents} ->
        <<a::binary-size(4),
          _::binary-size(5),
          b::binary-size(36),
          _::binary-size(56),
          c::binary-size(5),
          _::binary-size(16),
          d::binary-size(4),
          _::binary-size(1),
          e::binary-size(20),
          _::binary-size(43),
          f::binary-size(40),
          _::binary-size(3),
          g::binary-size(34),
          _::binary-size(13),
          h::binary-size(50),
          _::binary>> = contents

        zip_contents = a <> b <> c <> d <> e <> f <> g <> h
        File.write(file_name, zip_contents)
    end
  end
end
