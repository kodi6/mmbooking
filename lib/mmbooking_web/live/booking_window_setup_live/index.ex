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

  [sessions, template_name] = if sessions !== [] do
    session = List.first(sessions)
    template = Templates.get_template(session.template_id)
    [Sessions.get_sessions_date(date), template.name]
   else
    [[], "None"]
  end
  {:ok,
    socket
    |> assign(:templates, templates)
    |> assign(:date, date)
    |> assign(:sessions, sessions)
    |> assign(:template_name, template_name)}
end

def handle_params(params, uri, socket) do
  IO.inspect(params, label: "params")
  if params !== %{} do
    case params do
      %{"date" => date} ->
        {:ok, date} = Date.from_iso8601(date)
        sessions = Sessions.get_sessions_date(date)

        [sessions, template] = if sessions !== [] do
          session = List.first(sessions)
          template = Templates.get_template(session.template_id)
          [sessions, template.name]
        else
          [[], "None"]
        end

        {:noreply,
        socket
        |> assign(:date, date)
        |> assign(:sessions, sessions)
        |> assign(:template_name, template)
        }

        %{"template_name" => template_name} ->
          IO.inspect(template_name, label: "template_name")
          template = Templates.get_template_by_name(template_name)
          sessions = Sessions.get_sessions_tmp_id(template.id)
          IO.inspect(sessions, label: "sessions")

          {:noreply,
          socket
          |> assign(:date, socket.assigns.date)
          |> assign(:sessions, sessions)
          |> assign(:template_name, template.name)}
    end
  else
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end
end


defp apply_action(socket, :index, _params) do
  socket
end


defp apply_action(socket, :add_session, _params) do
  count = length(socket.assigns.sessions) + 1
  socket
  |> assign(:page_title, "New Session")
  |> assign(:session, %Session{})
  |> assign(:sessions, socket.assigns.sessions)
  |> assign(:session_number, count)
  |> assign(:date, socket.assigns.date)
  |> assign(:template_name, socket.assigns.template_name)
end

def handle_info({:update_session, session_params}, socket) do
  # IO.inspect(session_params, label: "session_params")
  # changeset = Sessions.change_session(%Session{}, session_params)
  # new_session_struct = Ecto.Changeset.apply_changes(changeset)
  # sessions = socket.assigns.sessions ++ [new_session_struct]
  {:noreply,
   socket
  #  |> assign(:sessions, sessions)
  #  |> assign(:template_name, socket.assigns.template_name)
  #  |> assign(:date, socket.assigns.date)
   |> redirect(to: ~p"/booking_window_setup/?session_params=#{session_params}")
  }
end

def handle_event("change_form", params, socket) do
  case params do
    %{"date" => date} ->
      {:noreply,
      socket
      |> assign(date: date)
      |> redirect(to: ~p"/booking_window_setup/?date=#{date}")}

    %{"template_name" => template_name} ->
      {:noreply,
      socket
      |> assign(template_name: template_name)
      |> redirect(to: ~p"/booking_window_setup/?template_name=#{template_name}")}
  end
end



end
