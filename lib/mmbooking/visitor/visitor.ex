defmodule Mmbooking.Visitor.Visitor do
  use Ecto.Schema
  import Ecto.Changeset



  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
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
    |> cast(attrs, [:email, :first_name, :last_name, :dob, :country, :city, :visited, :last_visit, :preferred_date, :alternate_date, :arrival_date, :departure_date, :note, :status, :stay])
  end


  def personal_changeset(visitor, attrs) do
    visitor
    |> cast(attrs, [:email, :first_name, :last_name, :dob, :country, :city, :last_visit, :visited])
    |> validate_required([:email, :first_name, :last_name, :dob, :country, :city])
    |> validate_length(:first_name, max: 20)
    |> validate_length(:last_name, max: 20)
    |> validate_length(:city, max: 30)
    |> validate_length(:last_visit, max: 30)
  end

  def booking_changeset(visitor, attrs) do
    visitor
    |> cast(attrs, [:preferred_date, :alternate_date, :arrival_date, :departure_date, :note, :stay])
    |> validate_required([:preferred_date, :alternate_date, :arrival_date, :departure_date, :note, :stay])
    |> preferred_arrival_check()
    |> preferred_departure_check()
    |> arrival_departure_check()
  end





  def preferred_arrival_check(booking_changeset) do
      preferred_date = get_field(booking_changeset, :preferred_date)
      arrival_date = get_field(booking_changeset, :arrival_date)
    if preferred_date != nil and arrival_date != nil do
      if Date.compare(preferred_date, arrival_date) == :eq do
        add_error(booking_changeset, :arrival_date, "Sorry! Visit on the same day as your Arrival Date in or around Auroville is not permitted.")
      else
        booking_changeset
      end
    else
      booking_changeset
    end
  end

  def preferred_departure_check(booking_changeset) do
      preferred_date = get_field(booking_changeset, :preferred_date)
      departure_date = get_field(booking_changeset, :departure_date)
    if preferred_date != nil and departure_date != nil do
        if Date.compare(preferred_date, departure_date) == :gt do
           add_error(booking_changeset, :departure_date, "Sorry! Visit later than you Departure Date is not permitted.")
        else
          booking_changeset
      end
    else
      booking_changeset
    end
  end


  def arrival_departure_check(booking_changeset) do
    arrival_date = get_field(booking_changeset, :arrival_date)
    departure_date = get_field(booking_changeset, :departure_date)
if arrival_date != nil and departure_date != nil do
    if Date.compare(arrival_date, departure_date) == :eq do
      add_error(booking_changeset, :departure_date, "Sorry! Visitors coming for a day visit to Auroville are not permitted.")
    else
      booking_changeset
    end
  else
    booking_changeset
  end
end


end
