defmodule MmbookingWeb.BookingLive.SelfBookingFormComponent do
  use MmbookingWeb, :live_component

  alias Mmbooking.Visitors
  def render(assigns) do
    ~H"""
    <div>
    <.simple_form
          for={@form}
          phx-target={@myself}
          phx-change="validate"
          phx-submit="save"
        >

          <h1 class="font-bold text-2xl">Self Booking form</h1>

          <div class="flex space-x-6 mt-6">
          <label class="font-semibold" >Full Name :</label> <div><%= @visitor.first_name%></div>
          </div>
          <.custom_input field={@form[:preferred_date]} type="date" label="Preferred Date" value={} required/>
          <.custom_input field={@form[:alternate_date]} type="date" label="Alternate Date" value={} required/>
          <.custom_input field={@form[:stay]} type="text" label="Place" value={} required/>
          <.custom_input field={@form[:arrival_date]} type="date" label="Arrival Date" value={} required/>
          <.custom_input field={@form[:departure_date]} type="date" label="Departure Date" value={} required/>
          <.custom_input field={@form[:note]} type="textarea" label="Note" value={} required/>
          <:actions>

            <.button phx-disable-with="Saving...">Submit</.button>
          </:actions>
      </.simple_form>
    </div>
    """
  end

  def update(%{visitor: visitor} = assigns, socket) do
    changeset = Visitors.change_booking_changeset(visitor)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end


  @impl true
  def handle_event("validate", %{"visitor" => visitor_params}, socket) do
    changeset =
      socket.assigns.visitor
      |> Visitors.change_booking_changeset(visitor_params)
      |> Map.put(:action, :validate)
    {:noreply, assign_form(socket, changeset)}
  end


  def handle_event("save", %{"visitor" => visitor_params}, socket) do
    save_user(socket, socket.assigns.action, visitor_params)
  end

  defp save_user(socket, :edit, visitor_params) do
    case Visitors.update_visitor(socket.assigns.visitor, visitor_params) do
      {:ok, _visitor} ->

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
