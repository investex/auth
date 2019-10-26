defmodule Auth.Sagas.Registration do
  use Rop

  import Utils.Rop

  alias Auth.Forms.AuthForm
  alias Persistence.{Repo, User}

  def process(%{user: _} = params) do
    params
    |> AuthForm.validate_input
    >>> hash_password
    >>> insert_record
  end

  defp hash_password(%{user: %{password: password} = user} = params) do
    user
    |> Map.put(:password_hash, Argon2.hash_pwd_salt(password))
    |> put_back(params, :user)
  end

  defp insert_record(%{user: user} = params) do
    %User{}
    |> User.changeset(user)
    |> Repo.insert
    >>> put_back(params, :user)
  end
end
