defmodule Invest.Auth.Factory do
  use ExMachina.Ecto, repo: Invest.Persistence.Repo

  use Invest.Auth.Factories.AuthForms
  use Invest.Auth.Factories.UserParams
end
