defmodule Generate do
  # Generate.create_bin("challenge2.bin")
  def create_bin(file_name) do
    # our key
    key = "AVISI-dJ1Neg"

    # we destruct our key into the specific parts
    <<
    a::binary-size(2), # AV
    b::binary-size(1), # I
    c::binary-size(3), # SI-
    d::binary-size(1), # d
    e::binary-size(1), # J
    f::binary-size(1), # 1
    g::binary-size(3) # Neg
    >> = key

    # we generate the binary string with random data
    binary_data =
      random_string(54)
      <> d <> # 3
      random_string(2)
      <> e <> # 4
      random_string(2)
      <> f <> # 5
      random_string(30)
      <> g <> # 6
      random_string(30)
      <> a <> # 0
      random_string(1)
      <> b <> # 1
      random_string(10)
      <> c <> # 2
      random_string(102)

    # here we write the binary_data to a file
    :ok = File.write(file_name, binary_data, [:binary])
  end

  # Generates a random string for the given length
  def random_string(length), do: :crypto.strong_rand_bytes(length)
end
