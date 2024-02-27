defmodule MmbookingWeb.NewVisitorLive.PreviewFormComponent do
  use MmbookingWeb, :live_component


  alias Mmbooking.Visitors

  def render(assigns) do
    ~H"""
    <div>
    hii3333
    <.simple_form
          for={@form}
          phx-target={@myself}
          phx-change="validate"
          phx-submit="save"
        >

          <.input field={@form[:email]} type="email" label="email" value={@visitor_email} />
          <.input field={@form[:first_name]} type="text" label="First Name" value={@personal.first_name} readonly/>
          <.input field={@form[:last_name]} type="text" label="Last Name" value={@personal.last_name}/>
          <.input field={@form[:dob]} type="date" label="Dob Of Birth" value={@personal.dob} />
          <.input field={@form[:country]} type="text" label="Country" value={@personal.country} />
          <.input field={@form[:city]} type="text" label="City" value={@personal.city}/>
          <.input field={@form[:visited]} type="text" label="City" value={@personal.visited}/>
          <%= if @personal.visited == "Yes" do %>
          <.input field={@form[:last_visit]} type="text" label="Last visit" value={@personal.last_visit}/>
          <% end %>
          <.input field={@form[:preferred_date]} type="date" label="Preferred Date" value={@booking.preferred_date} />
          <.input field={@form[:alternate_date]} type="date" label="Alternate Date" value={@booking.alternate_date} />
          <.input field={@form[:stay]} type="text" label="Place" value={@booking.stay} />
          <.input field={@form[:arrival_date]} type="date" label="Arrival Date" value={@booking.arrival_date} />
          <.input field={@form[:departure_date]} type="date" label="Departure Date" value={@booking.departure_date} />
          <.input field={@form[:note]} type="textarea" label="Note" value={@booking.note}  />


          <:actions>
          <.link phx-click="back-booking" phx-target={@myself}>
            <.button>Back</.button>
          </.link>
            <.button phx-disable-with="Saving...">Submit</.button>
          </:actions>
      </.simple_form>
    </div>
    """
  end


  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(:personal, assigns.personal_changeset.changes)
     |> assign(:booking, assigns.booking_changeset.changes)
     |> assign(assigns)
     |> assign_form(assigns.preview_changeset)}
  end


  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  @impl true
  def handle_event("save", %{"visitor" => visitor_params}, socket) do
    case Visitors.create_visitor(visitor_params) do
      {:ok, visitor} ->
        {:noreply,
         socket
         |> assign(:visitor, visitor)
         |> push_navigate(to: ~p"/mmaccess/submission_successful?id=#{visitor.id}")}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :preview_changeset, changeset)}
    end
  end


  @impl true
  def handle_event("back-booking", _, socket) do
    send(self(), {:update_step, 1})
    send(self(), {:update_booking_changeset, socket.assigns.booking_changeset})
    {:noreply,
    socket
    |> assign(:step, 1)}
  end

end
