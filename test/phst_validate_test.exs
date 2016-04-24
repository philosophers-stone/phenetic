defmodule PhStValidateTest do
  use ExUnit.Case
  doctest PhStValidate

  test "validate is identity List" do
    list = [1, 2, "a", "b"]
    validate = PhStValidate.build_validator(list)
    assert [true, true, true, true] == validate.(list)
  end

  test "validate is identity Tuple" do
    list = {1, 2, "a", "b"}
    validate = PhStValidate.build_validator(list)
    assert {true, true, true, true } == validate.(list)
  end
end
