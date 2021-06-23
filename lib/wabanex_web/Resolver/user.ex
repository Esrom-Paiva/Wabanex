defmodule WabanexWeb.Resolver.User do

  alias Wabanex.Users.{Create, Get}

  def create(%{input: params}, _context), do: Create.call(params)
  def get(%{id: user_id}, _context), do: Get.call(user_id)
end
