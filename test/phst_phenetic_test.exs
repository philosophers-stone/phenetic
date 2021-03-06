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

  test "congruent quote do output" do
    data = quote do: Enum.map(1..3, fn(x) -> x*x end)
    data_transform = quote do: Enum.map(1..3, fn(y) -> y*y end)
    congruent =  PhStPhenetic.congruent(data)
    assert true == congruent.(data_transform)
  end

  test "similar respects List size not equal" do
    list = [1, 2, "a", "b"]
    new_list = [400, "a string", 300, "b string", 400]
    similar = PhStPhenetic.similar(list)
    assert true == similar.(new_list)
  end

  test "similar is identity List" do
    list = [1, 2, "a", "b"]
    similar = PhStPhenetic.similar(list)
    assert true == similar.(list)
  end

  test "similar tracks data types" do
    list = [1, 2, "a", "b"]
    similar = PhStPhenetic.similar(list)
    assert false == similar.(["a", :a, 1, 2])
  end

  test "exact respects List size and types" do
    list = [1, 2, "a", "b"]
    new_list = [400, "a string", 300, "b string"]
    exact = PhStPhenetic.exact(list)
    assert false == exact.(new_list)
  end

end
