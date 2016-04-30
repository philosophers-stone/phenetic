defmodule PhStMutate do

  import PhStTransform

  @doc """
  Returns a mutation of the original data structure. This is
  a data structure that is congruent to the original but with
  randomized elements.
  """
  def mutate(data) do
    mutate_potion = %{ Atom => &from_atom/3,
                      Integer => &from_integer/3,
                      Float   =>  &from_float/3,
                      BitString => &from_bitstring/3,
                     }


    PhStTransform.transform(data, mutate_potion)
  end

  #[Atom, Integer, Float, BitString, Regexp, PID, Function, Reference, Port, Tuple, List, Map]
  # I should really learn how to at least make all the basic types via macros.

  defp from_atom(_atom,  depth) do

  end

  defp from_integer(_integer,  depth) do

  end

  defp from_float(_float,  depth) do

  end

  defp from_bitstring(_bitstring,  depth) do

  end

  # Stolen from http://stackoverflow.com/questions/13480462/erlang-can-i-get-a-list-of-all-currently-registered-atoms
  defp all_atoms
     atoms_starting_at(0)
  end

  defp atom_by_number(n) do
    :erlang.binary_to_term(<<131,75,n::24>>)
  end

  defp atoms_starting_at(n) do
    try do
            [atom_by_number(n)] ++ atoms_starting_at(n + 1)
    rescue
      ArguementError -> []
    end
end
