defmodule MmbookingWeb.NewVisitorLive.PreviewFormComponent do
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

        <div class="space-x-20"><span class="font-semibold">Email :</span> <span class="ml-6"><%= @visitor_email %></span></div>
        <div class="space-x-20"><span class="font-semibold">First Name :</span> <span class="ml-6"><%= @personal.first_name %></span></div>
        <div class="space-x-20"><span class="font-semibold">Last Name :</span> <span class="ml-6"><%= @personal.last_name %></span></div>
        <div class="space-x-20"><span class="font-semibold">Dob Of Birth :</span> <span class="ml-6"><%= @personal.dob %></span></div>
        <div class="space-x-20"><span class="font-semibold">Country :</span> <span class="ml-6"><%= @personal.country %></span></div>
        <div class="space-x-20"><span class="font-semibold">City :</span> <span class="ml-6"><%= @personal.city %></span></div>
        <div class="space-x-20"><span class="font-semibold">Visited :</span> <span class="ml-6"><%= @personal.visited %></span></div>
        <%= if @personal.visited == "Yes" do %>
        <div class="space-x-20"><span class="font-semibold">Last visit :</span> <span class="ml-6"><%= @personal.last_visit %></span></div>
        <% end %>
        <div class="space-x-20"><span class="font-semibold">Preferred Date :</span> <span class="ml-6"><%= @booking.preferred_date %></span></div>
        <div class="space-x-20"><span class="font-semibold">Alternate Date :</span> <span class="ml-6"><%= @booking.alternate_date %></span></div>
        <div class="space-x-20"><span class="font-semibold">Arrival Date :</span> <span class="ml-6"><%= @booking.departure_date %></span></div>
        <div class="space-x-20"><span class="font-semibold">Note :</span> <span class="ml-6"><%= @booking.note %></span></div>
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
