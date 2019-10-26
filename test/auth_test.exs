defmodule AuthTest do
  use Auth.RepoCase
  import Auth.Factory
  alias Persistence.User

  setup do
    %{params: %{user: build(:user_params)}}
  end

  describe "register" do
    test "returns an error when params are invalid" do
      assert {:error, %Ecto.Changeset{}} = Auth.register(%{user: %{}})
    end

    test "returns registered user when params are valid", %{params: params} = _ do
      assert {:ok, %{user: %User{}}} = Auth.register(params)
    end

    test "returns an error when new user is invalid", %{params: params} = _ do
      Auth.register(params)
      assert {:error, %Ecto.Changeset{}} = Auth.register(params)
    end
  end

  describe "authenticate" do
    test "returns an error when no user matches email" do
      params = %{user: build(:user_params)}
      assert {:error, _} = Auth.authenticate(params)
    end

    test "returns an error when email matches but password does not", %{params: %{user: %{email: email}} = params} = _ do
      bad_params = %{user: %{email: email, password: "wrong"}}
      Auth.register(params)
      assert {:error, _} = Auth.authenticate(bad_params)
    end

    test "returns ok and a user when email and password match", %{params: params} = _ do
      Auth.register(params)
      assert {:ok, %{user: %User{}}} = Auth.authenticate(params)
    end
  end
end
