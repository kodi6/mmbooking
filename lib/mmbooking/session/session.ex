defmodule Mmbooking.Session.Session do
  use Ecto.Schema
  import Ecto.Changeset

  alias Mmbooking.Booking.Booking

  schema "sessions" do
    field :date, :date
    field :session_number, :integer
    field :group_name, :string
    field :chamber_from_time, :time
    field :chamber_to_time, :time
    field :reporting_from_time, :time
    field :reporting_to_time, :time
    field :seats, :integer
    field :is_active, :boolean, default: false

    has_many :bookings, Booking


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:session_number, :group_name, :chamber_from_time, :chamber_to_time, :reporting_from_time, :reporting_to_time, :seats, :date])
    |> validate_required([:session_number, :group_name, :chamber_from_time, :chamber_to_time, :reporting_from_time, :reporting_to_time, :seats, :date])
  end
end
