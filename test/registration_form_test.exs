defmodule RegistrationFormTest do
  use Auth.RepoCase
  import Auth.Factory
  alias Auth.RegistrationForm

  describe "validations" do
    setup do
      [form: build(:registration_form)]
    end

    test "has a valid factory", %{form: form} = _ do
      assert RegistrationForm.changeset(form).valid?
    end

    test "is invalid without an email", %{form: form} = _ do
      changeset = %{form | email: nil} |> RegistrationForm.changeset
      refute changeset.valid?
    end

    test "is invalid without a password", %{form: form} = _ do
      changeset = %{form | password: nil} |> RegistrationForm.changeset
      refute changeset.valid?
    end
  end
end
