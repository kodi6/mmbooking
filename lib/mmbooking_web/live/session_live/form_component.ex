defmodule MmbookingWeb.SessionLive.FormComponent do
  use MmbookingWeb, :live_component



  alias Mmbooking.Sessions
  alias Mmbooking.Templates

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to add session.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <h1>Template Name: <%= @template_name %></h1>
        <%!-- <.input field={@form[:template_id]} type="hidden" value={@template_id}/> --%>
        <.input field={@form[:session_number]} type="number" label="Session" value={@session_number}/>
        <.input field={@form[:chamber_from_time]} type="time" label="Chamber Time-From"  value={"17:42"}/>
        <.input field={@form[:chamber_to_time]} type="time" label="Chamber Time-To" value={"17:42"}/>
        <.input field={@form[:reporting_from_time]} type="time" label="Reporting Time-From" value={"17:42"}/>
        <.input field={@form[:reporting_to_time]} type="time" label="Reporting Time-To" value={"17:42"}/>
        <.input field={@form[:group_name]} type="select" prompt="Select Type" options={["Group A", "Group B"]}label="Visitor Type" value={"A"}/>
        <.input field={@form[:seats]} type="text" label="Maximum seats" value={3}/>
        <:actions>
          <.button phx-disable-with="Saving...">Submit</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{session: session} = assigns, socket) do
    changeset = Sessions.change_session(session)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"session" => session_params}, socket) do
    changeset =
      socket.assigns.session
      |> Sessions.change_session(session_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"session" => session_params}, socket) do
    save_session(socket, socket.assigns.action, session_params)
  end


  defp save_session(socket, :edit_session, session_params) do
    case Sessions.update_session(socket.assigns.session, session_params) do
      {:ok, _session} ->

        {:noreply,
         socket
        #  |> put_flash(:info, "User updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end


  defp save_session(socket, :add_session, session_params) do
    template_name = Templates.get_template_by_name(socket.assigns.template_name)
    session_params = Map.put(session_params, "template_id", template_name.id)
    case Sessions.create_session(session_params) do
      {:ok, _session} ->

        {:noreply,
         socket
        #  |> put_flash(:info, "session created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
