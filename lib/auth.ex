defmodule Invest.Auth do
  defdelegate register(params), to: Invest.Auth.Sagas.Registration, as: :process
  defdelegate authenticate(params), to: Invest.Auth.Sagas.Authentication, as: :process
end
