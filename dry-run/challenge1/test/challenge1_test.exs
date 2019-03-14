defmodule Challenge1Test do
  use ExUnit.Case
  doctest Challenge1

  test "decodes the string 'FOO'" do
    assert Challenge1.decode("😎😢😢") == "FOO"
  end

  test "decodes the string 'BAR'" do
    assert Challenge1.decode("😂😀🤬") == "BAR"
  end


  test("Converts 😴 to 0") do
    assert(Challenge1.to_ascii("😴") == "0")
  end

  test("Converts 🤑 to 1") do
    assert(Challenge1.to_ascii("🤑") == "1")
  end

  test("Converts 😖 to 2") do
    assert(Challenge1.to_ascii("😖") == "2")
  end

  test("Converts 😝 to 3") do
    assert(Challenge1.to_ascii("😝") == "3")
  end

  test("Converts 🧐 to 4") do
    assert(Challenge1.to_ascii("🧐") == "4")
  end

  test("Converts 😙 to 5") do
    assert(Challenge1.to_ascii("😙") == "5")
  end

  test("Converts 😌 to 6") do
    assert(Challenge1.to_ascii("😌") == "6")
  end

  test("Converts ☺️ to 7") do
    assert(Challenge1.to_ascii("☺️") == "7")
  end

  test("Converts 😊 to 8") do
    assert(Challenge1.to_ascii("😊") == "8")
  end

  test("Converts 😇 to 9") do
    assert(Challenge1.to_ascii("😇") == "9")
  end


  test("Converts 😀 to A") do
    assert(Challenge1.to_ascii("😀") == "A")
  end

  test("Converts 😂 to B") do
    assert(Challenge1.to_ascii("😂") == "B")
  end

  test("Converts 😍 to C") do
    assert(Challenge1.to_ascii("😍") == "C")
  end

  test("Converts 😅 to D") do
    assert(Challenge1.to_ascii("😅") == "D")
  end

  test("Converts 😘 to E") do
    assert(Challenge1.to_ascii("😘") == "E")
  end

  test("Converts 😎 to F") do
    assert(Challenge1.to_ascii("😎") == "F")
  end

  test("Converts 🤓 to G") do
    assert(Challenge1.to_ascii("🤓") == "G")
  end

  test("Converts 🤩 to H") do
    assert(Challenge1.to_ascii("🤩") == "H")
  end

  test("Converts 😜 to I") do
    assert(Challenge1.to_ascii("😜") == "I")
  end

  test("Converts 😛 to J") do
    assert(Challenge1.to_ascii("😛") == "J")
  end

  test("Converts 🙂 to K") do
    assert(Challenge1.to_ascii("🙂") == "K")
  end

  test("Converts 🙃 to L") do
    assert(Challenge1.to_ascii("🙃") == "L")
  end

  test("Converts 😉 to M") do
    assert(Challenge1.to_ascii("😉") == "M")
  end

  test("Converts 😔 to N") do
    assert(Challenge1.to_ascii("😔") == "N")
  end

  test("Converts 😢 to O") do
    assert(Challenge1.to_ascii("😢") == "O")
  end

  test("Converts 🥺 to P") do
    assert(Challenge1.to_ascii("🥺") == "P")
  end

  test("Converts 🤯 to Q") do
    assert(Challenge1.to_ascii("🤯") == "Q")
  end

  test("Converts 🤬 to R") do
    assert(Challenge1.to_ascii("🤬") == "R")
  end

  test("Converts 😫 to S") do
    assert(Challenge1.to_ascii("😫") == "S")
  end

  test("Converts 😭 to T") do
    assert(Challenge1.to_ascii("😭") == "T")
  end

  test("Converts 😤 to U") do
    assert(Challenge1.to_ascii("😤") == "U")
  end

  test("Converts 😱 to V") do
    assert(Challenge1.to_ascii("😱") == "V")
  end

  test("Converts 🤔 to W") do
    assert(Challenge1.to_ascii("🤔") == "W")
  end

  test("Converts 😓 to X") do
    assert(Challenge1.to_ascii("😓") == "X")
  end

  test("Converts 🤫 to Y") do
    assert(Challenge1.to_ascii("🤫") == "Y")
  end

  test("Converts 🤭 to Z") do
    assert(Challenge1.to_ascii("🤭") == "Z")
  end
end
