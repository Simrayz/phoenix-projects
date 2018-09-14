defmodule ThorWeb.SessionController do
  use ThorWeb, :controller

  def new(conn, _) do
    render(conn, "new.json")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case ThorWeb.Auth.login_by_email_and_pass(conn, email, pass) do
      {:ok, conn} ->
        conn
        |> put_status(:ok)
        |> render("sign_in.json", message: "Succesfully logged in!")
      {:error, _reason, conn} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(ThorWeb.ErrorView)
        |> render("401.json", message: "Invalid email/password combination!")
    end
  end

  def delete(conn, _) do
    conn
    |> ThorWeb.Auth.logout()
    |> render(ThorWeb.SessionView, "sign_out.json", message: "Logged out!")
  end
end
