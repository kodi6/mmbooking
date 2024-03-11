defmodule Mmbooking.Templates do
  import Ecto.Query, warn: false


  alias Mmbooking.Repo
  alias Mmbooking.Template.Template
  alias Mmbooking.Session.Session


  def list_templates do
    Repo.all(Template)
  end


  def create_template(attrs \\ %{}) do
    %Template{}
    |> Template.changeset(attrs)
    |> Repo.insert()
  end


def create_session(template_id) do

  sessions = [
    %{date: ~D[2023-03-11],
    session_number: 1,
    group_name: "Group A",
    chamber_from_time: ~T[08:50:00],
    chamber_to_time: ~T[09:15:00],
    reporting_from_time: ~T[08:15:00],
    reporting_to_time: ~T[08:30:00],
    seats: 50,
    is_active: true,
    template_id: template_id},



    %{date: ~D[2023-03-11],
    session_number: 2,
    group_name: "Group A",
    chamber_from_time: ~T[09:20:00],
    chamber_to_time: ~T[09:45:00],
    reporting_from_time: ~T[08:15:00],
    reporting_to_time: ~T[08:30:00],
    seats: 50,
    is_active: false,
    template_id: template_id},

    %{date: ~D[2023-03-11],
    session_number: 3,
    group_name: "Group B",
    chamber_from_time: ~T[09:50:00],
    chamber_to_time: ~T[10:05:00],
    reporting_from_time: ~T[08:30:00],
    reporting_to_time: ~T[08:45:00],
    seats: 50,
    is_active: true,
    template_id: template_id},


    %{date: ~D[2023-03-11],
    session_number: 4,
    group_name: "Group B",
    chamber_from_time: ~T[10:10:00],
    chamber_to_time: ~T[10:25:00],
    reporting_from_time: ~T[08:30:00],
    reporting_to_time: ~T[08:45:00],
    seats: 50,
    is_active: true,
    template_id: template_id},

    %{date: ~D[2023-03-11],
    session_number: 5,
    group_name: "Group B",
    chamber_from_time: ~T[10:30:00],
    chamber_to_time: ~T[10:45:00],
    reporting_from_time: ~T[08:30:00],
    reporting_to_time: ~T[08:45:00],
    seats: 50,
    is_active: true,
    template_id: template_id},

    %{date: ~D[2023-03-11],
    session_number: 6,
    group_name: "Group B",
    chamber_from_time: ~T[10:50:00],
    chamber_to_time: ~T[11:05:00],
    reporting_from_time: ~T[08:30:00],
    reporting_to_time: ~T[08:45:00],
    seats: 50,
    is_active: true,
    template_id: template_id},


    %{date: ~D[2023-03-11],
    session_number: 7,
    group_name: "Group B",
    chamber_from_time: ~T[11:10:00],
    chamber_to_time: ~T[11:25:00],
    reporting_from_time: ~T[08:30:00],
    reporting_to_time: ~T[08:45:00],
    seats: 50,
    is_active: false,
    template_id: template_id}
  ]

  Enum.map(sessions, fn session ->
    changeset = Session.changeset(%Session{}, session)
    Repo.insert!(changeset)
  end)
end


end
