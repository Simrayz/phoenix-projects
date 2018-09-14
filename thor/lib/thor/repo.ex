defmodule Thor.Repo do
  use Ecto.Repo,
    otp_app: :thor,
    adapter: Ecto.Adapters.Postgres
end
