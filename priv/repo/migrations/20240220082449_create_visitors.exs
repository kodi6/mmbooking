defmodule Mmbooking.Repo.Migrations.CreateVisitors do
  use Ecto.Migration

  def change do
    create table(:visitors) do
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :dob, :date
      add :country, :string
      add :city, :string
      add :visited, :boolean, default: false, null: false
      add :last_visit, :string
      add :preferred_date, :date
      add :alternate_date, :date
      add :arrival_date, :date
      add :departure_date, :date
      add :note, :text
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
