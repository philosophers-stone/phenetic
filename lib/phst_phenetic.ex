defmodule PhStPhenetic do

  import PhStValidate

  @doc """
  Returns a function returns true or false if the argument to the function
  is congruent to the orginal data structure. congruent is defined by all
  data structures have the same size as the original and having the same
  data types as basic elements.
  """
  def congruent(edata) do
    vfunc = build_validator(edata)
    true_state = vfunc.(edata)
    fn(data) ->
      vfunc.(data) == true_state
    end
  end

  @doc """
  Returns a function returns true or false if the argument to the function
  is similar to the orginal data structure. The difference between congruent
  and similar is that similar relaxs the constraint on size for data structures.
  """
  def similar(edata) do
   vfunc = build_validator(edata)
   fn(data) ->
    similar?(vfunc.(data))
   end
  end

end
