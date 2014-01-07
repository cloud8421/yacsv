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

end
