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
      add :visitor_id, references(:visitors, on_delete: :nothing, type: :binary_id)
      add :session_id, references(:sessions, on_delete: :nothing, type: :binary_id)



      timestamps(type: :utc_datetime)
    end
  end
end
