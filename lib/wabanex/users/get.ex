defmodule Wabanex.Users.Get do
  alias Wabanex.{User, Training, Repo}
  alias Ecto.UUID

  import Ecto.Query

  def call(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:error, "Invalid Id"}

  defp handle_response({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, load_training(user)}
    end
  end

  defp load_training(user) do
    today = Date.utc_today()

    query =
      from training in Training,
        where: ^today >= training.start_date and ^today <= training.end_date

        Repo.preload(user, trainings: {first(query, :inserted_at), :exercises})
  end
end
