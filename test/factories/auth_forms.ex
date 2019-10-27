defmodule Invest.Auth.Factories.AuthForms do
  defmacro __using__(_opts) do
    quote do
      def auth_form_factory do
        %Invest.Auth.Forms.AuthForm{
          email: Faker.Internet.email(),
          password: Faker.String.base64()
        }
      end
    end
  end
end
