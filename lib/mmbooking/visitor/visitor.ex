defmodule Mmbooking.Visitor.Visitor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "visitors" do
    field :status, :string
    field :visited, :boolean, default: false
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :dob, :date
    field :country, :string
    field :city, :string
    field :last_visit, :string
    field :preferred_date, :date
    field :alternate_date, :date
    field :arrival_date, :date
    field :departure_date, :date
    field :note, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  # def changeset(visitor, attrs) do
  #   visitor
  #   |> cast(attrs, [:email, :first_name, :last_name, :dob, :country, :city, :visited, :last_visit, :preferred_date, :alternate_date, :arrival, :departure, :note, :status])
  #   |> validate_required([:email, :first_name, :last_name, :dob, :country, :city, :visited, :last_visit, :preferred_date, :alternate_date, :arrival, :departure, :note, :status])
  # end


  def changeset(visitor, attrs) do
    visitor
    |> cast(attrs, [:first_name])
    |> validate_required([:first_name])
  end
end
