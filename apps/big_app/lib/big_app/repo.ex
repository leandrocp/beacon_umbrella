defmodule BigApp.Repo do
  use Ecto.Repo,
    otp_app: :big_app,
    adapter: Ecto.Adapters.Postgres
end
