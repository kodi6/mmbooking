defmodule Mmbooking.Repo.Migrations.CreateTemplates do
  use Ecto.Migration

  def change do
    create table(:templates) do
      add :types, :string

      timestamps(type: :utc_datetime)
    end
  end
end
