defmodule PhStPhenetic do

  import PhStValidate

  def congruent(edata) do
    vfunc = build_validator(edata)
    true_state = vfunc.(edata)
    fn(data) ->
      vfunc.(data) == true_state
    end
  end

  def similar(edata) do
   vfunc = build_validator(edata)
   fn(data) ->
    similar?(vfunc.(data))
   end
  end

end
