defmodule Mmbooking.Booking.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookings" do
    field :reason, :string
    field :date, :date
    field :session, :string
    field :has_visited, :boolean, default: false
    field :seats, :integer
    field :other_reason, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:has_visited, :date, :session, :seats, :reason, :other_reason])
    |> validate_required([:has_visited, :date, :session, :seats, :reason, :other_reason])
  end
end
