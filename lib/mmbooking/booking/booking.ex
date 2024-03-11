defmodule Mmbooking.Booking.Booking do
  use Ecto.Schema
  import Ecto.Changeset


  alias Mmbooking.Visitor.Visitor
  alias Mmbooking.Session.Session


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bookings" do
    field :date, :date
    field :has_visited, :boolean, default: false

    belongs_to :visitor, Visitor
    belongs_to :session, Session

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:has_visited, :date, :visitor, :Session])
    |> validate_required([:has_visited, :date, :visitor, :Session])
  end
end
