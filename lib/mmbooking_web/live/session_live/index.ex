defmodule MmbookingWeb.SessionLive.Index do
  use MmbookingWeb, :live_view

  alias Mmbooking.Templates
  alias Mmbooking.Sessions
  alias Mmbooking.Session.Session


  def mount(_params, _session, socket) do
    templates =  Templates.list_templates()
    {:ok,
    socket
    |> assign(:templates, templates)
    |> assign(:template_name, "None")
    |> assign(:sessions, [])}
  end


  def handle_params(params, _url, socket) do
    if params == %{} do
      {:noreply, apply_action(socket, socket.assigns.live_action, params)}
    else
      template_id = Map.get(params, "template_id")
      template = Templates.get_template(template_id)
      templates =  Templates.list_templates()
      sessions = Sessions.get_sesssions_tmp_id(template_id)
      {:noreply,
      socket
      |> assign(:templates, templates)
      |> assign(:template_name, template.name)
      |> assign(:sessions, sessions)}
    end
  end

  defp apply_action(socket, :add_session, _params) do
    last_session = List.last(socket.assigns.sessions)
    socket
    |> assign(:page_title, "New session")
    |> assign(:session, %Session{})
    |> assign(:template_name, socket.assigns.template_name)
    |> assign(:sessions, socket.assigns.sessions)
    |> assign(:session_number, last_session.session_number + 1)

  end


  defp apply_action(socket, :index, _params) do
    socket
  end


  def handle_event("template", params, socket) do
    name = Map.get(params, "name")
    template = Templates.get_template_by_name(name)
    if template do
      {:noreply,
        socket
        |> put_flash(:error, "Template already exists!")}
    else
      [template, sessions] = if String.contains?(name, "darshan") do
        template = Templates.create_template(params)
        sessions = Sessions.create_darshan_session(template.id)
        [template, sessions]
      else
        template = Templates.create_template(params)
        sessions = Sessions.create_default_session(template.id)
        [template, sessions]
      end
      templates =  Templates.list_templates()
      {:noreply,
      socket
      |> assign(:templates, templates)
      |> assign(:template_name, template.name)
      |> assign(:sessions, sessions)}
    end
  end

  def handle_event("change_template", %{"name" => name}, socket) do
    [sessions, template] = if name == "" do
      [[], "None"]
    else
      template = Templates.get_template_by_name(name)
      sessions = Sessions.get_sesssions_tmp_id(template.id)
      [sessions, template.name]
    end
    templates =  Templates.list_templates()
    {:noreply,
    socket
    |> assign(:templates, templates)
    |> assign(:sessions, sessions)
    |> assign(:template_name, template)}
  end
end
