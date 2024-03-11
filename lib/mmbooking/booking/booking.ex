defmodule Mmbooking.Booking.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookings" do
    field :date, :date
    field :session, :string
    field :has_visited, :boolean, default: false


    belongs_to :visitor, Visitor
    belongs_to :session, Session



    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:has_visited, :date, :session, :seats, :reason, :other_reason, :visitor, :Session])
    |> validate_required([:has_visited, :date, :session, :seats, :reason, :other_reason, :Session, :visitor])
  end
end
