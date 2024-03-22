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
    |> assign(:assigned, false)
    |> assign(:templates, templates)
    |> assign(:date, date)
    |> assign(:sessions, sessions)
    |> assign(:template_name, template_name)}
  end

  def handle_params(params, _uri, socket) do
    if params != %{} do
      date = Map.get(params, "date")
      template_name = Map.get(params, "template_name")
      {:ok, date} = Date.from_iso8601(date)
      if template_name == "" do
        {:noreply,
        socket
        |> assign(:date, date)
        |> assign(:sessions, [])
        |> assign(:template_name, "None")}
      else
        template = Templates.get_template_by_name(template_name)
        sessions = Sessions.get_sessions_tmp_id(template.id)
        exists = Repo.exists?(from s in Session, where: s.date == ^date)

        if exists do
          sessions = Repo.all(from s in Session, where: s.date == ^date)

          session = List.first(sessions)
          template = Templates.get_template(session.template_id)
          {:noreply,
          socket
          |> assign(:date, date)
          |> assign(:sessions, sessions)
          |> assign(:template_name, template.name)
          |> assign(:assigned, true)
          }
        else
          sessions = Enum.filter(sessions, fn session -> session.date == nil end)
          {:noreply,
          socket
          |> assign(:date, date)
          |> assign(:sessions, sessions)
          |> assign(:template_name, template.name)
          |> assign(:assigned, false)

        }
        end
      end
    else
      {:noreply, apply_action(socket, socket.assigns.live_action, params)}
    end
  end

  def handle_event("window_template", %{"date" => date, "template_name" => template_name}, socket) do
    {:noreply,
       socket
    |> redirect(to: ~p"/booking_window_setup/?date=#{date}&template_name=#{template_name}")}
  end

  def handle_event("save", _params, socket) do
    Enum.map(socket.assigns.sessions, fn session ->
      session_params = Map.from_struct(session)
      updated_session_params = Map.put(session_params, :date, socket.assigns.date)
      Sessions.create_session(updated_session_params)
    end)
    {:noreply,
    socket
    |> assign(:assigned, true)}
  end

  defp apply_action(socket, :index, _params) do
    socket
  end

  defp apply_action(socket, :add_session, _params) do
    count = length(socket.assigns.sessions) + 1
    socket
    |> assign(:page_title, "New User")
    |> assign(:session, %Session{})
    |> assign(:session_number, count)
    |> assign(:date, socket.assigns.date)
    |> assign(:template_name, socket.assigns.template_name)
  end

  def handle_event("remove", %{"id" => id, "template_id" => template_id}, socket) do
    session = Sessions.get_session!(id)
    {:ok, _} = Sessions.delete_session(session)
    sessions = Sessions.get_sessions_tmp_id(template_id) |> Enum.filter(fn session -> session.date == nil end)
    {:noreply,
    socket
    |> assign(:sessions, sessions)}
  end

end
