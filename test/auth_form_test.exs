defmodule AuthFormTest do
  use Auth.RepoCase
  import Auth.Factory
  alias Auth.Forms.AuthForm

  describe "validations" do
    setup do
      [form: build(:auth_form)]
    end

    test "has a valid factory", %{form: form} = _ do
      assert AuthForm.changeset(form).valid?
    end

    test "is invalid without an email", %{form: form} = _ do
      changeset = %{form | email: nil} |> AuthForm.changeset
      refute changeset.valid?
    end

    test "is invalid without a password", %{form: form} = _ do
      changeset = %{form | password: nil} |> AuthForm.changeset
      refute changeset.valid?
    end
  end
end
