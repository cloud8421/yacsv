defmodule YacsvTest do
  use ExUnit.Case
  doctest Yacsv

  test "it correctly parses a string" do
    data = Yacsv.parse("some, values, in a csv file")
    assert data == ["some", "values", "in a csv file"]
  end

  test "can customize the separator" do
    data = Yacsv.parse("some-values-in a csv file", '-')
    assert data == ["some", "values", "in a csv file"]
  end

  test "supports quoted values" do
    data = Yacsv.parse("OSI, Office of Strategic Influence, \"Hello, Helicopter!\", 2003")
    assert data == ["OSI", "Office of Strategic Influence", "Hello, Helicopter!", "2003"]
  end

  test "can customize the quote char" do
    data = Yacsv.parse("OSI, Office of Strategic Influence, 'Hello, Helicopter!', 2003", ',', '\'')
    assert data == ["OSI", "Office of Strategic Influence", "Hello, Helicopter!", "2003"]
  end
end
