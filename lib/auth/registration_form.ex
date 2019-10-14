defmodule Auth.RegistrationForm do
  use Ecto.Schema

  embedded_schema do
    field :email, :string
    field :password, :string
  end

  def changeset(form, params \\ %{}) do
    form
    |> Ecto.Changeset.cast(params, [:email, :password])
    |> Ecto.Changeset.validate_required([:email, :password])
  end
end
