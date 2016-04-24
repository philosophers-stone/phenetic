defmodule PhStPheneticTest do
  use ExUnit.Case
  doctest PhStPhenetic

  test "congruent is identity List" do
    list = [1, 2, "a", "b"]
    congruent = PhStPhenetic.congruent(list)
    assert true == congruent.(list)
  end

  test "congruent respects List size" do
    list = [1, 2, "a", "b"]
    new_list = [400, "a string", 300, "b string"]
    congruent = PhStPhenetic.congruent(list)
    assert true == congruent.(new_list)
  end

  test "congruent respects List size not equal" do
    list = [1, 2, "a", "b"]
    new_list = [400, "a string", 300, "b string", 400]
    congruent = PhStPhenetic.congruent(list)
    assert false == congruent.(new_list)
  end



  test "similar is identity List" do
    list = [1, 2, "a", "b"]
    similar = PhStPhenetic.similar(list)
    assert true == similar.(list)
  end
end
