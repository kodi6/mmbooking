defmodule Mmbooking.Template.Template do
  use Ecto.Schema
  import Ecto.Changeset

  schema "templates" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(template, attrs) do
    template
    |> cast(attrs, [:types])
    |> validate_required([:types])
  end
end
