defmodule Auth.Factory do
  use ExMachina.Ecto, repo: Persistence.Repo

  use Auth.Factories.AuthForms
  use Auth.Factories.UserParams
end
