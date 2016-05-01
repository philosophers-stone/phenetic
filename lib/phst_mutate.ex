defmodule PhStMutate do

  import PhStTransform

  @doc """
  Returns a mutation of the original data structure. This is
  a data structure that is congruent to the original but with
  randomized elements.
  """
  def mutate(data) do
    mutate_potion = %{ Atom => &from_atom/2,
                      Integer => &from_integer/2,
                      Float   =>  &from_float/2,
                      BitString => &from_bitstring/2,
                     }


    PhStTransform.transform(data, mutate_potion)
  end

  #[Atom, Integer, Float, BitString, Regexp, PID, Function, Reference, Port, Tuple, List, Map]

  @max_atoms 16777216
  defp from_atom(_atom, _depth) do
    random_atom_less_than(@max_atoms)
  end

  defp from_integer(integer, _depth) do
    round(:rand.normal * :rand.uniform(integer))
  end

  defp from_float(float, _depth) do
    :rand.normal * float
  end

  # Idea taken from https://github.com/gutschilla/elixir-helper-random/blob/master/lib/random.ex
  defp from_bitstring(bitstring, _depth) do
    str_length = String.length(bitstring)
    length = abs(from_integer(str_length,[]))
    1..length
    |> Enum.map_join(
      fn(_) -> bitstring |> String.at( :rand.uniform( str_length ) - 1 ) end
      )
  end

  # Stolen from http://stackoverflow.com/questions/13480462/erlang-can-i-get-a-list-of-all-currently-registered-atoms
  # defp all_atoms
  #    atoms_starting_at(0)
  # end

  defp random_atom_less_than(0) do
    raise ArgumentError, message: "Did not find any atoms"
  end

  defp random_atom_less_than(n) do
    index = :rand.uniform(n)
    try do
      atom_by_number(index)
    rescue
      ArgumentError -> random_atom_less_than(round(n/2))
    end
  end

  defp atom_by_number(n) do
    :erlang.binary_to_term(<<131,75,n::24>>)
  end

#   defp atoms_starting_at(n) do
#     try do
#             [atom_by_number(n)] ++ atoms_starting_at(n + 1)
#     rescue
#       ArguementError -> []
#     end
#   end
end
