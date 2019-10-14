defmodule Auth do
  @moduledoc """
  Documentation for Auth.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Auth.hello()
      :world

  """

  alias Auth.RegistrationForm
  alias Persistence.{Repo, User}

  def register(params) do
    %RegistrationForm{}
    |> RegistrationForm.changeset(params)
    |> process_registration
  end

  def authenticate(%{email: email, password: password}) do
    User
    |> Repo.get_by(email: email)
    |> Argon2.check_pass(password)
  end

  defp process_registration(%Ecto.Changeset{valid?: false} = changeset) do
    {:error, changeset}
  end
  defp process_registration(%Ecto.Changeset{valid?: true, changes: %{password: password} = changes}) do
    %User{}
    |> User.changeset(Map.put(changes, :password_hash, Argon2.hash_pwd_salt(password)))
    |> Repo.insert
  end
end
