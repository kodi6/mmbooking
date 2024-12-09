defmodule MmbookingWeb.BookingWindowSetupLive.Index do
  use MmbookingWeb,  :live_view

  import Ecto.Query, warn: false

  alias Mmbooking.Templates
  alias Mmbooking.Repo
  alias Mmbooking.Sessions
  alias Mmbooking.Session.Session



def mount(_params, _session, socket) do
  templates = Templates.list_templates
  date = Date.utc_today
  sessions = Sessions.get_sessions_date(date)

  [sessions, template_name, assign] = if sessions !== [] do
    session = List.first(sessions)
    template = Templates.get_template(session.template_id)
    [Sessions.get_sessions_date(date), template.name, true]
   else
    [[], "None", false]
  end
  {:ok,
    socket
    |> assign(:is_assigned, assign)
    |> assign(:templates, templates)
    |> assign(:date, date)
    |> assign(:sessions, sessions)
    |> assign(:template_name, template_name)}
end



# defp apply_action(socket, :index, _params) do
#   socket
# end


# defp apply_action(socket, :add_session, _params) do
#   count = length(socket.assigns.sessions) + 1
#   socket
#   |> assign(:page_title, "New Session")
#   |> assign(:session, %Session{})
#   |> assign(:sessions, socket.assigns.sessions)
#   |> assign(:session_number, count)
#   |> assign(:date, socket.assigns.date)
#   |> assign(:template_name, socket.assigns.template_name)
# end





def handle_event("change_date", %{"date" => date}, socket) do
   {:ok, date} = Date.from_iso8601(date)
   sessions = Sessions.get_sessions_date(date)

   [sessions, template, assign] = if sessions !== [] do
        session = List.first(sessions)
        template = Templates.get_template(session.template_id)
        [sessions, template.name, true]
      else
        [[], "None", false]
      end


 {:noreply,
 socket
 |> assign(:is_assigned, assign)
 |> assign(:date, date)
 |> assign(:sessions, sessions)
 |> assign(:template_name, template)
 }
end

def handle_event("change_template", %{"template_name" => template_name}, socket) do
  template = Templates.get_template_by_name(template_name)
  sessions = Sessions.get_sessions_tmp_id(template.id) |> Enum.filter(fn session -> session.date == nil end)
{:noreply,
socket
|> assign(:date, socket.assigns.date)
|> assign(:sessions, sessions)
|> assign(:template_name, template.name)
}
end




def handle_event("add session", params, socket) do
session = List.first(socket.assigns.sessions)

session_number = length(socket.assigns.sessions) + 1

params = %{
  session_number: session_number,
  group_name: nil,
  chamber_from_time: nil,
  chamber_to_time: nil,
  reporting_from_time: ~T[08:30:00],
  reporting_to_time: ~T[08:45:00],
  seats: 50,
  template_id: session.template_id
}

changeset = Sessions.change_session_params(%Session{}, params)
new_session_struct = Ecto.Changeset.apply_changes(changeset)

sessions = socket.assigns.sessions ++ [new_session_struct]



{:noreply,
socket
|> assign(:sessions, sessions)
|> assign(:date, socket.assigns.date)
|> assign(:template_name, socket.assigns.template_name)
}
end


def handle_event("save", params, socket) do
  sessions = Enum.map(socket.assigns.sessions, fn session ->
    session_params = Map.from_struct(session)
    updated_session_params = Map.put(session_params, :date, socket.assigns.date)
    Sessions.create_session(updated_session_params)
  end)

  {:noreply,
  socket
  |> assign(:is_assigned, true)

  }
end

def handle_event("inc", params, socket) do
  IO.inspect(params, label: "paramsr")
  {:noreply, socket}
end

end
