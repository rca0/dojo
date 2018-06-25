defmodule PhoenixApi.User do
  use PhoenixApi.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password_hash])
    |> validate_required([:name, :email, :password_hash])
  end
end
