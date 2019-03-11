defmodule Challenge2 do

  def parse(file_name) do
    case File.read(file_name) do
      {:ok, contents} ->
        content_size = byte_size(contents) - 17
        <<_::binary-size(content_size), key::binary>> = contents
        IO.inspect(key)
    end
  end

end
