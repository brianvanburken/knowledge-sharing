defmodule Generate do
  def create_bin(file_name, key) when byte_size(key) == 26 do
    # we destruct our key into the specific parts, length = 26
    <<
    a::binary-size(5),
    b::binary-size(1),
    c::binary-size(3),
    d::binary-size(7),
    e::binary-size(4),
    f::binary-size(2),
    g::binary-size(4)
    >> = key

    # we generate the binary string with random data
    binary_data =
      :crypto.strong_rand_bytes(54)
      <> d <> # 3
      :crypto.strong_rand_bytes(2)
      <> e <> # 4
      :crypto.strong_rand_bytes(2)
      <> g <> # 6
      :crypto.strong_rand_bytes(30)
      <> f <> # 5
      :crypto.strong_rand_bytes(30)
      <> a <> # 0
      :crypto.strong_rand_bytes(1)
      <> b <> # 1
      :crypto.strong_rand_bytes(10)
      <> c <> # 2
      :crypto.strong_rand_bytes(102)

    File.write(file_name, binary_data)
  end
end
