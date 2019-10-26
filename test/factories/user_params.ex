defmodule Auth.Factories.UserParams do
  defmacro __using__(_opts) do
    quote do
      def user_params_factory do
        %{
          email: Faker.Internet.email(),
          password: Faker.String.base64()
        }
      end
    end
  end
end
