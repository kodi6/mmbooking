defmodule MmbookingWeb.BookingWindowSetupLive.Index do
  use MmbookingWeb,  :live_view

  import Ecto.Query, warn: false

  alias Mmbooking.Templates
  alias Mmbooking.Repo
  alias Mmbooking.Template.Template
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
        [[], nil]
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
    {:noreply, socket}
  end



  def handle_event("window_template", %{"date" => date, "template_name" => template_name}, socket) do
    {:noreply,
       socket
    |> redirect(to: ~p"/booking_window_setup/?date=#{date}&template_name=#{template_name}")}
  end


end



# {:noreply,
# socket
# |> redirect(to: ~p"/sessions/add_session/#{id}/edit_session")}
