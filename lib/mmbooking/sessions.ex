defmodule Mmbooking.Sessions do
  import Ecto.Query, warn: false

alias Mmbooking.Repo
alias Mmbooking.Template.Template
alias Mmbooking.Session.Session


def get_sessions_tmp_id(template_id) do
  Session
  |> where(template_id: ^template_id)
  |> order_by(asc: :session_number)
  |> Repo.all()
end

def get_sessions_date(date) do
  Session
  |> where(date: ^date)
  |> order_by(asc: :session_number)
  |> Repo.all()
end

def change_session(%Session{} = session, attrs \\ %{}) do
  Session.changeset(session, attrs)
end

def create_default_session(template_id) do
  sessions = [
     %{
       session_number: 1,
       group_name: "Group A",
       chamber_from_time: ~T[08:50:00],
       chamber_to_time: ~T[09:15:00],
       reporting_from_time: ~T[08:15:00],
       reporting_to_time: ~T[08:30:00],
       seats: 50,
       is_active: true,
       template_id: template_id
     },
     %{
       session_number: 2,
       group_name: "Group A",
       chamber_from_time: ~T[09:20:00],
       chamber_to_time: ~T[09:45:00],
       reporting_from_time: ~T[08:15:00],
       reporting_to_time: ~T[08:30:00],
       seats: 50,
       is_active: false,
       template_id: template_id
     },
     %{
       session_number: 3,
       group_name: "Group B",
       chamber_from_time: ~T[09:50:00],
       chamber_to_time: ~T[10:05:00],
       reporting_from_time: ~T[08:30:00],
       reporting_to_time: ~T[08:45:00],
       seats: 50,
       is_active: true,
       template_id: template_id
     },
     %{
       session_number: 4,
       group_name: "Group B",
       chamber_from_time: ~T[10:10:00],
       chamber_to_time: ~T[10:25:00],
       reporting_from_time: ~T[08:30:00],
       reporting_to_time: ~T[08:45:00],
       seats: 50,
       is_active: true,
       template_id: template_id
     },
     %{
       session_number: 5,
       group_name: "Group B",
       chamber_from_time: ~T[10:30:00],
       chamber_to_time: ~T[10:45:00],
       reporting_from_time: ~T[08:30:00],
       reporting_to_time: ~T[08:45:00],
       seats: 50,
       is_active: true,
       template_id: template_id
     },
     %{
       session_number: 6,
       group_name: "Group B",
       chamber_from_time: ~T[10:50:00],
       chamber_to_time: ~T[11:05:00],
       reporting_from_time: ~T[08:30:00],
       reporting_to_time: ~T[08:45:00],
       seats: 50,
       is_active: true,
       template_id: template_id
     },
     %{
       session_number: 7,
       group_name: "Group B",
       chamber_from_time: ~T[11:10:00],
       chamber_to_time: ~T[11:25:00],
       reporting_from_time: ~T[08:30:00],
       reporting_to_time: ~T[08:45:00],
       seats: 50,
       is_active: false,
       template_id: template_id
     }
  ]

  Enum.map(sessions, fn session ->
     changeset = Session.changeset(%Session{}, session)
     Repo.insert!(changeset)
  end)
 end



 def create_darshan_session(template_id) do
  sessions = [
     %{
       session_number: 1,
       group_name: "Group A",
       chamber_from_time: ~T[08:50:00],
       chamber_to_time: ~T[09:10:00],
       reporting_from_time: ~T[08:15:00],
       reporting_to_time: ~T[08:30:00],
       seats: 50,
       is_active: true,
       template_id: template_id
     },
     %{
       session_number: 2,
       group_name: "Group A",
       chamber_from_time: ~T[09:15:00],
       chamber_to_time: ~T[09:30:00],
       reporting_from_time: ~T[08:15:00],
       reporting_to_time: ~T[08:30:00],
       seats: 50,
       is_active: true,
       template_id: template_id
     },
     %{
       session_number: 3,
       group_name: "Group A",
       chamber_from_time: ~T[09:35:00],
       chamber_to_time: ~T[09:50:00],
       reporting_from_time: ~T[08:15:00],
       reporting_to_time: ~T[08:30:00],
       seats: 50,
       is_active: true,
       template_id: template_id
     },
     %{
       session_number: 4,
       group_name: "Group A",
       chamber_from_time: ~T[09:55:00],
       chamber_to_time: ~T[10:10:00],
       reporting_from_time: ~T[08:15:00],
       reporting_to_time: ~T[08:30:00],
       seats: 50,
       is_active: false,
       template_id: template_id
     },
     %{
       session_number: 5,
       group_name: "Group A",
       chamber_from_time: ~T[10:15:00],
       chamber_to_time: ~T[10:30:00],
       reporting_from_time: ~T[08:15:00],
       reporting_to_time: ~T[08:30:00],
       seats: 50,
       is_active: false,
       template_id: template_id
     },
     %{
       session_number: 6,
       group_name: "Group A",
       chamber_from_time: ~T[10:35:00],
       chamber_to_time: ~T[10:50:00],
       reporting_from_time: ~T[08:15:00],
       reporting_to_time: ~T[08:30:00],
       seats: 50,
       is_active: false,
       template_id: template_id
     },
     %{
       session_number: 7,
       group_name: "Group B",
       chamber_from_time: ~T[10:55:00],
       chamber_to_time: ~T[11:10:00],
       reporting_from_time: ~T[08:30:00],
       reporting_to_time: ~T[08:45:00],
       seats: 50,
       is_active: true,
       template_id: template_id
     },
     %{
       session_number: 8,
       group_name: "Group B",
       chamber_from_time: ~T[11:15:00],
       chamber_to_time: ~T[11:30:00],
       reporting_from_time: ~T[08:30:00],
       reporting_to_time: ~T[08:45:00],
       seats: 50,
       is_active: true,
       template_id: template_id
     }
  ]

  Enum.map(sessions, fn session ->
     changeset = Session.changeset(%Session{}, session)
     Repo.insert!(changeset)
  end)
 end


def create_session(attrs \\ %{}) do
  %Session{}
  |> Session.changeset(attrs)
  |> Repo.insert()
end

def list_sessions do
  Session
  |> order_by(asc: :session_number)
  |> Repo.all()
 end


def get_session!(id), do: Repo.get!(Session, id)

def update_session(%Session{} = session, attrs) do
  session
  |> Session.edit_changeset(attrs)
  |> Repo.update()
end


def delete_session(%Session{} = session) do
  Repo.delete(session)
end

end
