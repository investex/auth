defmodule Invest.Auth.Forms.AuthForm do
  use Ecto.Schema
  use Rop

  import Utils.Rop

  alias Invest.Auth.Forms.AuthForm

  embedded_schema do
    field :email, :string
    field :password, :string
  end

  def changeset(form, params \\ %{}) do
    form
    |> Ecto.Changeset.cast(params, [:email, :password])
    |> Ecto.Changeset.validate_required([:email, :password])
  end

  def validate_input(%{user: user} = params) do
    %AuthForm{}
    |> AuthForm.changeset(user)
    |> Ecto.Changeset.apply_action(:insert)
    >>> bind(Map.from_struct)
    >>> put_back(params, :user)
  end
end
