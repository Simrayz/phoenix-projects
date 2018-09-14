defmodule ThorWeb.Router do
  use ThorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug ThorWeb.Auth
  end

  scope "/api", ThorWeb do
    pipe_through :api

    resources "/users", UserController, only: [:index, :show, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end
end
