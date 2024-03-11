defmodule MmbookingWeb.SessionLive.Index do
  use MmbookingWeb, :live_view

  alias Mmbooking.Templates

  def mount(_params, _session, socket) do
    templates =  Templates.list_templates()
    {:ok,
    socket
    |> assign(:templates, templates)}
  end


  def handle_event("template", params, socket) do

    {:ok, template} = Templates.create_template(params)
    Templates.create_session(template.id)
    {:noreply,
    socket}
  end
end
