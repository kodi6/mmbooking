defmodule MmbookingWeb.NewVisitorLive.BookingFormComponent do
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
          <.input field={@form[:preferred_date]} type="date" label="Preferred Date" required/>
          <.input field={@form[:alternate_date]} type="date" label="Alternate Date" required/>
          <.input field={@form[:stay]} type="text" label="Place" required/>
          <.input field={@form[:arrival_date]} type="date" label="Arrival Date" required/>
          <.input field={@form[:departure_date]} type="date" label="Departure Date" required/>
          <.input field={@form[:note]} type="textarea" label="Note" required/>


          <:actions>
          <.link phx-click="back-personal" phx-target={@myself}>
            <.button>Back</.button>
          </.link>
            <.button phx-disable-with="Saving...">Next</.button>
          </:actions>
      </.simple_form>
    </div>
    """
  end





  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(assigns.booking_changeset)
     }
  end


  @impl true
  def handle_event("validate", %{"visitor" => visitor_params}, socket) do
    booking_changeset =
      socket.assigns.visitor
      |> Visitors.change_step2_changeset(visitor_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, booking_changeset)}
  end


  @impl true
  def handle_event("save", %{"visitor" => visitor_params}, socket) do
    booking_changeset =
      socket.assigns.visitor
      |> Visitors.change_step2_changeset(visitor_params)
      |> Map.put(:action, :validate)


      send(self(), {:update_booking_changeset, booking_changeset})
      send(self(), {:update_step, 2})


    {:noreply, assign_form(socket, booking_changeset)}
  end


  def handle_event("back-personal", _, socket) do
    send(self(), {:update_step, 0})
    send(self(), {:update_personal_changeset, socket.assigns.personal_changeset})



    {:noreply, socket |> assign(:step, 0)}
  end



  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end



end
