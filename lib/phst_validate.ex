defmodule PhStValidate do

  import PhStTransform

  @doc """
  Returns a function that replaces all terms in a data structure
  with either true or false depending on whether the term matches
  the type in the data structure given in the arguement.
  """
  def build_validator(data) do
    valid_potion = %{ Atom => &from_atom/3,
                      Integer => &from_integer/3,
                      Float   =>  &from_float/3,
                      BitString => &from_bitstring/3,
                     }

    {_, validator } = transmogrify(data, valid_potion)
    fn new_data ->
      PhStTransform.transform(new_data, PhStTransform.Potion.brewify(validator))
    end
  end

  #[Atom, Integer, Float, BitString, Regexp, PID, Function, Reference, Port, Tuple, List, Map]
  # I should really learn how to at least make all the basic types via macros.

  defp from_atom(_atom, potion, depth) do
    atom_f = PhStTransform.Potion.distill(Atom, potion)
    new_atom_f = fn
        (_a, p, ^depth) -> {true, p}
        (a, p, d) -> atom_f.(a, p, d)
      end
    new_potion = Map.put(potion, Atom, new_atom_f )
    {false, new_potion}
  end

  defp from_integer(_integer, potion, depth) do
    integer_f = PhStTransform.Potion.distill(Integer, potion)
    new_integer_f = fn
        (_i, p, ^depth) -> {true, p}
        (i, p, d) -> integer_f.(i, p, d)
      end
    new_potion = Map.put(potion, Integer, new_integer_f )
    {false, new_potion}
  end

  defp from_float(_float, potion, depth) do
    float_f = PhStTransform.Potion.distill(Float, potion)
    new_float_f = fn
        (_f, p, ^depth) -> {true, p}
        (f, p, d) -> float_f.(f, p, d)
      end
    new_potion = Map.put(potion, Float, new_float_f )
    {false, new_potion}
  end

  defp from_bitstring(_bitstring, potion, depth) do
    bitstring_f = PhStTransform.Potion.distill(BitString, potion)
    new_bitstring_f = fn
        (_b, p, ^depth) -> {true, p}
        (b, p, d) -> bitstring_f.(b, p, d)
      end
    new_potion = Map.put(potion, BitString, new_bitstring_f )
    {false, new_potion}
  end

  @doc """
  Evaluates the return of a build_validator function and returns
  true if all the terms in the data structure are the Atom true.
  """
  def similar?(data) do
    similar_potion = %{ List => &true_list/1,
                        Tuple => &true_tuple/1,
                        Map => &true_map/1,
                        Keyword => &true_keyword/1 }
    transform(data, similar_potion)
  end

  # return true if list consists entirely of true atoms.
  # Should probably raise error if any element is either
  # not true or false.

  defp true_list(list) do
    Enum.find(list, true, &is_false/1)
  end

  defp true_tuple(tuple) do
    tuple |> Tuple.to_list |> true_list
  end

  # Should we also look at keywords?
  defp true_map(map) do
    map |> Map.values |> true_list
  end

  defp true_keyword(klist) do
    klist |> Keyword.values |> true_list
  end

  defp is_false(item) do
    case item do
      true -> false
      false -> true
      _ -> raise(ArgumentError, message: "#{item} is not boolean")
    end
  end
end
