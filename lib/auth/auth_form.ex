defmodule Auth.AuthForm do
  use Ecto.Schema
  use Rop

  embedded_schema do
    field :email, :string
    field :password, :string
  end

  def changeset(form, params \\ %{}) do
    form
    |> Ecto.Changeset.cast(params, [:email, :password])
    |> Ecto.Changeset.validate_required([:email, :password])
  end

  def validate_input(params) do
    %Auth.AuthForm{}
    |> Auth.AuthForm.changeset(params)
    |> Ecto.Changeset.apply_action(:insert)
    >>> bind(Map.from_struct)
  end
end
