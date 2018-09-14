defmodule ThorWeb.UserController do
  use ThorWeb, :controller
  plug :authenticate when action in [:index, :show]

  alias Thor.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, "show.json", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> ThorWeb.Auth.login(user)
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> render("show.json", user: user)
      {:error, _} ->
        conn
        |> render(ThorWeb.ErrorView, "401.json", message: "Invalid User!")
    end
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> render(ThorWeb.ErrorView, "401.json", message: "You must be logged in to access this page!")
      |> halt()
    end
  end
end
