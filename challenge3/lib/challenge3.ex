defmodule Challenge3 do
  def repair do
    {:ok, contents} = File.read("./challenge3-corrupt.zip")
    <<part1::binary-size(4),
      _::binary-size(5),
      part2::binary-size(36),
      _::binary-size(56),
      part3::binary-size(5),
      _::binary-size(16),
      part4::binary-size(4),
      _::binary-size(1),
      part5::binary-size(20),
      _::binary-size(43),
      part6::binary-size(40),
      _::binary-size(3),
      part7::binary-size(34),
      _::binary-size(13),
      part8::binary-size(26),
      _::binary-size(105)>> = contents

    new_zip = part1 <> part2 <> part3 <> part4 <> part5 <> part6 <> part7 <> part8
    File.write!("./challenge3-repaired.zip", new_zip)
  end

  def corrupt do
    {:ok, contents} = File.read("./challenge3.zip")

    <<part1::binary-size(4),
      part2::binary-size(36),
      part3::binary-size(5),
      part4::binary-size(4),
      part5::binary-size(20),
      part6::binary-size(40),
      part7::binary-size(34),
      part8::binary-size(26)>> = contents

    corrupt =
      part1 <>
      random_string(5) <>
      part2 <>
      random_string(56) <>
      part3 <>
      random_string(16) <>
      part4 <>
      random_string(1) <>
      part5 <>
      random_string(43) <>
      part6 <>
      random_string(3) <>
      part7 <>
      random_string(13) <>
      part8 <>
      random_string(105)

    File.write!("./challenge3-corrupt.zip", corrupt, [:binary])
  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length)
    |> binary_part(0, length)
  end
end
