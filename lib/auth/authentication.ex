defmodule Auth.Authentication do
  use Rop

  alias Auth.AuthForm
  alias Persistence.{Repo, User}

  def process(params) do
    params
    |> AuthForm.validate_input
    >>> load_user
    >>> check_password
    >>> cast_to_user
  end

  defp load_user(%{email: email, password: password}) do
    User
    |> Repo.fetch_by(email: email)
    >>> bind(Map.from_struct)
    >>> bind(Map.put(:password, password))
  end

  defp check_password(%{password: password} = user) do
    user
    |> Argon2.check_pass(password)
  end

  defp cast_to_user(map) do
    User
    |> struct(map)
    |> ok
  end
end
