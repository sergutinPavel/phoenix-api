defmodule BlogWeb.UserController do
  use BlogWeb, :controller

  alias Blog.Accounts
  alias Blog.Accounts.User
  alias Blog.Guardian

  action_fallback BlogWeb.FallbackController

#  def index(conn, _params) do
#    users = Accounts.list_users()
#    render(conn, "index.json", users: users)
#  end

  #TODO return JWT
#  def create(conn, %{"user" => user_params}) do
#    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
#      conn
#      |> put_status(:created)
#      |> put_resp_header("location", user_path(conn, :show, user))
#      |> render("show.json", user: user)
#    end
#  end

#  def create(conn, %{"user" => user_params}) do
#    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
#         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
#      conn |> render("jwt.json", jwt: token)
#    end
#  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        new_conn = Guardian.Plug.sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)
#        claims = Guardian.Plug.current_claims(new_conn)
#        exp = Map.get(claims, "exp")

        new_conn
#        |> put_resp_header("authorization", "Bearer #{jwt}")
#        |> put_resp_header("x-expires", exp)
        |> render("jwt.json", jwt: jwt)
      {:error, _changeset} ->
        conn
        |> put_status(401)
        |> render("error.json", message: "Could not register")
    end
  end

#  def show(conn, %{"id" => id}) do
#    user = Accounts.get_user!(id)
#    render(conn, "show.json", user: user)
#  end

#  def update(conn, %{"id" => id, "user" => user_params}) do
#    user = Accounts.get_user!(id)
#
#    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
#      render(conn, "show.json", user: user)
#    end
#  end

#  def delete(conn, %{"id" => id}) do
#    user = Accounts.get_user!(id)
#    with {:ok, %User{}} <- Accounts.delete_user(user) do
#      send_resp(conn, :no_content, "")
#    end
#  end
end
