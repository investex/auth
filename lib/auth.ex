defmodule Auth do
  defdelegate register(params), to: Auth.Registration, as: :process
  defdelegate authenticate(params), to: Auth.Authentication, as: :process
end
