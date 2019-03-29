defmodule Generate do
  def corrupt(file_name) do
    case File.read(file_name) do
      {:ok, contents} ->
        <<part1::binary-size(4),
          part2::binary-size(36),
          part3::binary-size(5),
          part4::binary-size(4),
          part5::binary-size(20),
          part6::binary-size(40),
          part7::binary-size(34),
          part8::binary-size(50),
          part9::binary>> = contents

        IO.inspect(part9)

        corrupt_zip =
          part1 <>
          :crypto.strong_rand_bytes(5) <>
          part2 <>
          :crypto.strong_rand_bytes(56) <>
          part3 <>
          :crypto.strong_rand_bytes(16) <>
          part4 <>
          :crypto.strong_rand_bytes(1) <>
          part5 <>
          :crypto.strong_rand_bytes(43) <>
          part6 <>
          :crypto.strong_rand_bytes(3) <>
          part7 <>
          :crypto.strong_rand_bytes(13) <>
          part8 <>
          :crypto.strong_rand_bytes(105)

        File.write(file_name, corrupt_zip)
    end
  end
end
