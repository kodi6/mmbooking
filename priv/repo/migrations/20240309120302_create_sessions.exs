defmodule Mmbooking.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :session_number, :integer
      add :visitor_type, :string
      add :chamber_from_time, :time
      add :chamber_to_time, :time
      add :reporting_from_time, :time
      add :reporting_to_time, :time
      add :seats, :integer
      add :date, :date

      timestamps(type: :utc_datetime)
    end
  end
end