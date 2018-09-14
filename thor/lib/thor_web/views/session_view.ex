defmodule ThorWeb.SessionView do
  use ThorWeb, :view

  def render("sign_in.json", %{message: message}) do
    %{ message: message }
  end

  def render("sign_out.json", %{message: message}) do
    %{ message: message }
  end

end
