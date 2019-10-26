defmodule Auth do
  defdelegate register(params), to: Auth.Sagas.Registration, as: :process
  defdelegate authenticate(params), to: Auth.Sagas.Authentication, as: :process
end
