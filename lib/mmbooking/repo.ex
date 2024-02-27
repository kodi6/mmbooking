defmodule Mmbooking.Repo do
  use Ecto.Repo,
    otp_app: :mmbooking,
    adapter: Ecto.Adapters.Postgres
end
