defmodule ThorWeb.UserView do
  use ThorWeb, :view

  alias Thor.Accounts
  alias ThorWeb.UserView

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, username: user.username}
  end
end
