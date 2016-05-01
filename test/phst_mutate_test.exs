defmodule PhStMutateTest do
  use ExUnit.Case
  doctest PhStMutate

  test "Atom" do
   assert is_atom(PhStMutate.mutate(:a))
  end


end
