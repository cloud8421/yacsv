defmodule YacsvTest do
  use ExUnit.Case

  test "it correctly parses a string" do
    data = Yacsv.parse("some, values, in a csv file")
    assert data == ["some", "values", "in a csv file"]
  end

  test "can customize the separator" do
    data = Yacsv.parse("some-values-in a csv file", '-')
    assert data == ["some", "values", "in a csv file"]
  end

  test "supports quoted values" do
    data = Yacsv.parse("Muse, Absolution, \"Plugin, Baby\", 2004")
    assert data == ["Muse", "Absolution", "Plugin, Baby", "2004"]
  end

  test "can customize the quote char" do
    data = Yacsv.parse("Muse, Absolution, 'Plugin, Baby', 2004", ',', '\'')
    assert data == ["Muse", "Absolution", "Plugin, Baby", "2004"]
  end
end
