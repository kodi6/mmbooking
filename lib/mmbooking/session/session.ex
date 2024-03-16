defmodule Mmbooking.Session.Session do
  use Ecto.Schema
  import Ecto.Changeset

  alias Mmbooking.Booking.Booking
  alias Mmbooking.Template.Template
  alias Mmbooking.Repo
  alias Mmbooking.Session.Session



  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
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

    belongs_to :template, Template
    has_many :bookings, Booking


    timestamps(type: :utc_datetime)
  end

  @doc false
  def duplicate_changeset(session, attrs) do
    session
    |> cast(attrs, [:session_number, :group_name, :chamber_from_time, :chamber_to_time, :reporting_from_time, :reporting_to_time, :seats, :date, :template_id, :is_active])
    |> validate_required([:session_number, :group_name, :chamber_from_time, :chamber_to_time, :reporting_from_time, :reporting_to_time, :seats, :template_id])
    |> check_duplicate_from_time()
    |> check_duplicate_to_time()
  end

  def check_duplicate_from_time(changeset) do
    from_time = get_field(changeset, :chamber_from_time)
    if from_time do
       from_session = Repo.get_by(Session, chamber_from_time: from_time)
      if from_session do
        add_error(changeset, :chamber_from_time, "This From chamber time already exists")
      else
        changeset
      end
    else
      changeset
    end
   end

   def check_duplicate_to_time(changeset) do
    to_time = get_field(changeset, :chamber_to_time)
    if to_time do
       to_session = Repo.get_by(Session, chamber_to_time: to_time)
      if to_session do
        add_error(changeset, :chamber_to_time, "This TO chamber time already exists")
      else
        changeset
      end
    else
      changeset
    end
   end


   def changeset(session, attrs) do
    session
    |> cast(attrs, [:session_number, :group_name, :chamber_from_time, :chamber_to_time, :reporting_from_time, :reporting_to_time, :seats, :date, :template_id, :is_active])
    |> validate_required([:session_number, :group_name, :chamber_from_time, :chamber_to_time, :reporting_from_time, :reporting_to_time, :seats, :template_id])
  end


  def edit_changeset(session, attrs) do
    session
    |> cast(attrs, [:session_number, :group_name, :chamber_from_time, :chamber_to_time, :reporting_from_time, :reporting_to_time, :seats, :date, :template_id, :is_active])
    |> validate_required([:session_number, :group_name, :chamber_from_time, :chamber_to_time, :reporting_from_time, :reporting_to_time, :seats, :template_id])
  end



end
