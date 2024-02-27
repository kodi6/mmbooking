defmodule Mmbooking.Repo.Migrations.CreateVisitors do
  use Ecto.Migration

  def change do
    create table(:visitors, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :dob, :date
      add :country, :string
      add :city, :string
      add :visited, :string
      add :last_visit, :string
      add :preferred_date, :date
      add :alternate_date, :date
      add :arrival_date, :date
      add :departure_date, :date
      add :note, :text
      add :status, :string
      add :stay, :string


      timestamps(type: :utc_datetime)
    end
  end
end
