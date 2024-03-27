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
      IO.inspect(session, label: "session")
      template = Templates.get_template(session.template_id)

     [sessions, template_name] = if session.session_number !== 1 do
        [[], "None"]
      else
        [Sessions.get_sessions_date(date), template.name]
      end

      [sessions, template_name]
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


  def handle_params(params, _uri, socket) do
    # IO.inspect(params, label: "params")

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
            template = Templates.get_template_by_name(template_name)
            sessions = Sessions.get_sessions_tmp_id(template.id)
            {:noreply,
            socket
            |> assign(:date, socket.assigns.date)
            |> assign(:sessions, sessions)
            |> assign(:template_name, template.name)}

          _->
              new_params = Map.put(params, "date", socket.assigns.date)

              new_session = Sessions.create_session(new_params)

              changeset = Sessions.change_session(%Session{}, new_params)
              new_session_struct = Ecto.Changeset.apply_changes(changeset)
              sessions = socket.assigns.sessions ++ [new_session_struct]
          {:noreply,
            socket
            |> assign(:date, socket.assigns.date)
            |> assign(:sessions, sessions)
            |> assign(:template_name, socket.assigns.template_name)
            |> redirect(to: ~p"/booking_window_setup/?template_name=#{socket.assigns.template_name}")
          }
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
    |> assign(:page_title, "New User")
    |> assign(:session, %Session{})
    |> assign(:sessions, socket.assigns.sessions)
    |> assign(:session_number, count)
    |> assign(:date, socket.assigns.date)
    |> assign(:template_name, socket.assigns.template_name)
  end

  def handle_event("change_form", params, socket) do
    IO.inspect(params, label: "params99")
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

  def handle_event("save", params, socket) do

    sessions = Enum.filter(socket.assigns.sessions, fn session -> session.date == nil end)

    session6 = Enum.map(sessions, fn session ->
      session_params = Map.from_struct(session)
      updated_session_params = Map.put(session_params, :date, socket.assigns.date)
      Sessions.create_session(updated_session_params)
    end)

    sessions = Sessions.get_sessions_date(socket.assigns.date)


    {:noreply,
    socket
    |> assign(:sessions, sessions)

  }
  end


end
