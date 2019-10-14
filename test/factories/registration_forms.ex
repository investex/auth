defmodule Auth.Factories.RegistrationForms do
  defmacro __using__(_opts) do
    quote do
      def registration_form_factory do
        %Auth.RegistrationForm{
          email: Faker.Internet.email(),
          password: Faker.String.base64()
        }
      end
    end
  end
end
