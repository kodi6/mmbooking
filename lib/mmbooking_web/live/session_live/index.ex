defmodule MmbookingWeb.SessionLive.Index do
  use MmbookingWeb, :live_view

  alias Mmbooking.Templates
  alias Mmbooking.Repo

  alias Mmbooking.Sessions
  alias Mmbooking.Template.Template

  def mount(_params, _session, socket) do
    templates =  Templates.list_templates()
    {:ok,
    socket
    |> assign(:templates, templates)
    |> assign(:template_name, "None")
    |> assign(:sessions, [])}
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
        sessions = Sessions.create_session(template.id)
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
    IO.inspect(name, label: "name")
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
