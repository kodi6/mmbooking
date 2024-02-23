defmodule Mmbooking.Visitor.Visitor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "visitors" do
    field :status, :string
    field :visited, :string
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
    field :stay, :string


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(visitor, attrs) do
    visitor
    |> cast(attrs, [:email, :first_name, :last_name, :dob, :country, :city, :visited, :last_visit, :preferred_date, :alternate_date, :arrival_date, :departure_date, :note, :status])
  end


  def step1_changeset(visitor, attrs) do
    visitor
    |> cast(attrs, [:email, :first_name, :last_name, :dob, :country, :city, :last_visit, :visited])
    |> validate_required([:email, :first_name, :last_name, :dob, :country, :city, :visited])
  end

  def step2_changeset(visitor, attrs) do
    visitor
    |> cast(attrs, [:preferred_date, :alternate_date, :arrival_date, :departure_date, :note, :stay])
    |> validate_required([:preferred_date, :alternate_date, :arrival_date, :departure_date, :note, :stay])
  end



end
