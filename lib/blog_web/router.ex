defmodule BlogWeb.Router do
  use BlogWeb, :router

  alias Blog.Guardian

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api/v1", BlogWeb do
    pipe_through :api

#    resources "/users", UserController, only: [:create, :show]
    post "/register", UserController, :create
    post "/login", UserController, :login
  end

  scope "/api/v1", BlogWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/my_user", UserController, :show
  end

end
