defmodule Mmbooking.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :session_number, :integer
      add :group_name, :string
      add :chamber_from_time, :time
      add :chamber_to_time, :time
      add :reporting_from_time, :time
      add :reporting_to_time, :time
      add :seats, :integer
      add :date, :date
      add :is_active, :boolean, default: false, null: false
      add :template_id, references(:templates, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end
    create index(:sessions, [:template_id])
  end
end
