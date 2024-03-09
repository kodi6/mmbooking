defmodule Mmbooking.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add :has_visited, :boolean, default: false, null: false
      add :date, :date
      add :session, :string
      add :seats, :integer
      add :reason, :string
      add :other_reason, :text

      timestamps(type: :utc_datetime)
    end
  end
end
