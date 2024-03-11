defmodule Mmbooking.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :has_visited, :boolean, default: false, null: false
      add :date, :date
      add :status, :string
      add :visitor_id, references(:visitors, on_delete: :nothing, type: :binary_id)
      add :session_id, references(:sessions, on_delete: :nothing, type: :binary_id)



      timestamps(type: :utc_datetime)
    end
  end
end
