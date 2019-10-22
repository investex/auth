defmodule AuthTest do
  use Auth.RepoCase
  alias Persistence.User

  setup do
    [email: Faker.Internet.email, password: "password"]
  end

  describe "register" do
    test "returns an error when params are invalid" do
      assert {:error, %Ecto.Changeset{}} = Auth.register(%{})
    end

    test "returns registered user when params are valid", %{email: email, password: password} = _ do
      assert {:ok, %User{}} = Auth.register(%{email: email, password: password})
    end

    test "returns an error when new user is invalid", %{email: email, password: password} = _ do
      Auth.register(%{email: email, password: password})
      assert {:error, %Ecto.Changeset{}} = Auth.register(%{email: email, password: password})
    end
  end

  describe "authenticate" do
    test "returns an error when no user matches email" do
      assert {:error, _} = Auth.authenticate(%{email: "bad@email", password: "badpassword"}) |> IO.inspect
    end

    test "returns an error when email matches but password does not", %{email: email, password: password} = _ do
      Auth.register(%{email: email, password: password})
      assert {:error, _} = Auth.authenticate(%{email: email, password: "wrong"})
    end

    test "returns ok and a user when email and password match", %{email: email, password: password} = _ do
      Auth.register(%{email: email, password: password})
      assert {:ok, %User{}} = Auth.authenticate(%{email: email, password: password})
    end
  end
end
