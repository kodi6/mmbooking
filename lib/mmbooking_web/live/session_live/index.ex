defmodule MmbookingWeb.SessionLive.Index do
  use MmbookingWeb, :live_view

  alias Mmbooking.Templates
  alias Mmbooking.Session

  def mount(_params, _session, socket) do
    templates =  Templates.list_templates()
    {:ok,
    socket
    |> assign(:templates, templates)}
  end



  def handle_params(%{"template_id" => template_id}, _uri, socket) do
    IO.inspect(template_id, label: "template_id")
    sessions = Session.get_sesssions_tmp_id(template_id)
    template = Templates.get_template(template_id)

    {:noreply,
    socket
    |> assign(:sessions, sessions)
    |> assign(:template_name, template.name)
  }
  end

  def handle_event("template", params, socket) do
    {:ok, template} = Templates.create_template(params)
    Templates.create_session(template.id)
    {:noreply,
    socket}
  end


  def handle_event("change_template", %{"id" => id}, socket) do
    {:noreply,
    socket
    |> push_patch(to: ~p"/sessions/?template_id=#{id}")}
  end

end
