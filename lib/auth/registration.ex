defmodule Auth.Registration do
  use Rop

  alias Auth.AuthForm
  alias Persistence.{Repo, User}

  def process(params) do
    params
    |> AuthForm.validate_input
    >>> hash_password
    >>> insert_record
  end

  defp hash_password(%{password: password} = params) do
    params
    |> Map.put(:password_hash, Argon2.hash_pwd_salt(password))
    |> ok
  end

  defp insert_record(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert
  end
end
