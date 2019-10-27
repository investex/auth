defmodule Invest.Auth.Sagas.Authentication do
  use Rop

  import Utils.Rop

  alias Invest.Auth.Forms.AuthForm
  alias Invest.Persistence.{Repo, User}

  def process(%{user: _} = params) do
    params
    |> AuthForm.validate_input
    >>> load_user
    >>> check_password
    >>> cast_to_user
  end

  defp load_user(%{user: %{email: email, password: password}} = params) do
    User
    |> Repo.fetch_by(email: email)
    >>> bind(Map.from_struct)
    >>> bind(Map.put(:password, password))
    >>> put_back(params, :user)
  end

  defp check_password(%{user: %{password: password} = user} = params) do
    user
    |> Argon2.check_pass(password)
    >>> put_back(params, :user)
  end

  defp cast_to_user(%{user: user} = params) do
    User
    |> struct(user)
    |> put_back(params, :user)
  end
end
