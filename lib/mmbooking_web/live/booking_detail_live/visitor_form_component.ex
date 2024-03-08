defmodule MmbookingWeb.BookingDetailLive.VisitorFormComponent do
  use MmbookingWeb, :live_component

  alias Mmbooking.Visitors

  alias Mmbooking.Visitors
  def render(assigns) do
    ~H"""
    <div>
      <.simple_form
          for={@form}
          phx-target={@myself}
          phx-submit="edit"
        >
          <.custom_input field={@form[:email]} type="email" label="email"  />
          <.custom_input field={@form[:first_name]} type="text" label="First Name"  required />
          <.custom_input field={@form[:last_name]} type="text" label="Last Name"  required />
          <.custom_input field={@form[:dob]} type="date" label="Dob Of Birth"  required />
          <.custom_input field={@form[:country]} type="text" label="Country"  required />
          <.custom_input field={@form[:city]} type="text" label="City"  required />
          <:actions>
            <.button phx-disable-with="Saving...">Save</.button>
          </:actions>
      </.simple_form>
    </div>
    """
  end


  @impl true
  def update(%{visitor: visitor} = assigns, socket) do
    changeset = Visitors.change_personal_changeset(visitor)
    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  def handle_event("edit", %{"visitor" => visitor_params}, socket) do
    case Visitors.update_visitor_personal(socket.assigns.visitor, visitor_params) do
      {:ok, _user} ->

        {:noreply,
         socket
         |> put_flash(:info, "User updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

end
