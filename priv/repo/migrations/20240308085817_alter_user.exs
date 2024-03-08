defmodule Mmbooking.Repo.Migrations.AlterUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string
      add :first_name, :string
      add :last_name, :string
    end
  end
end
