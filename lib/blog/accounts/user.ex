defmodule Blog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Accounts.User


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :password_hash, :string
    # Virtual fields:
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation]) # Remove hash, add pw + pw confirmation
    |> validate_required([:email, :password, :password_confirmation]) # Remove hash, add pw + pw confirmation
    |> validate_format(:email, ~r/@/) # Check that email is valid
    |> validate_length(:password, min: 6) # Check that password length is >= 6
    |> validate_confirmation(:password) # Check that password === password_confirmation
    |> unique_constraint(:email)
    |> put_password_hash
  end
#  def changeset(user, attrs) do
#    user
#    |> cast(attrs, [:email, :password_hash])
#    |> validate_required([:email, :password_hash])
#    |> unique_constraint(:email)
#  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
      ->
        put_change(changeset, :password_hash, Comeonin.Pbkdf2.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
