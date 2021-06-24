defmodule WabanexWeb.Resolver.Training do

  alias Wabanex.Trainings.Create

  def create(%{input: params}, _context), do: Create.call(params)
end
