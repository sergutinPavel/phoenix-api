defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", BlogWeb do
    pipe_through :api

#    resources "/users", UserController, only: [:create, :show]
    post "/register", UserController, :create
    post "/login", UserController, :login
  end
end
