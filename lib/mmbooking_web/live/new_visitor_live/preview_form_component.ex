defmodule MmbookingWeb.NewVisitorLive.PreviewFormComponent do
  use MmbookingWeb, :live_component


  alias Mmbooking.Visitors
  alias Mmbooking.EmailNotifier

  def render(assigns) do
    ~H"""
    <div>
    <.simple_form
          for={@form}
          phx-target={@myself}
          phx-change="validate"
          phx-submit="save"
        >

        <div class="container">
                <div class="field font-semibold">Visitor Email:</div>
                <div class="value"><%= @visitor_email %></div>
                <div class="value"><.input field={@form[:email]} type="hidden"  value={@visitor_email}/></div>
            </div>

            <div class="container">
                <div class="field font-semibold">First Name :</div>
                <div class="value"><%= @personal.first_name %></div>
                <div class="value"><.input field={@form[:first_name]} type="hidden"  value={@personal.first_name} /></div>
            </div>

            <div class="container">
                <div class="field font-semibold">Last Name :</div>
                <div class="value"><%= @personal.last_name %></div>
                <div class="value"><.input field={@form[:last_name]} type="hidden"  value={@personal.last_name}/></div>
            </div>

            <div class="container">
                <div class="field font-semibold">Date Of Birth :</div>
                <div class="value"><%= @personal.dob %></div>
                <div class="value"><.input field={@form[:dob]} type="hidden"  value={@personal.dob} /></div>
            </div>

            <div class="container">
                <div class="field font-semibold">Country :</div>
                <div class="value"><%= @personal.country %></div>
                <div class="value"><.input field={@form[:country]} type="hidden"  value={@personal.country} /></div>
            </div>

            <div class="container">
                <div class="field font-semibold">City :</div>
                <div class="value"><%= @personal.city %></div>
                <div class="value"><.input field={@form[:city]} type="hidden"  value={@personal.city}/></div>
            </div>

            <div class="container">
                <div class="field font-semibold">Visited :</div>
                <div class="value"><%= @personal.visited %></div>
                <div class="value"><.input field={@form[:visited]} type="hidden"  value={@personal.visited}/></div>
            </div>

            <%= if @personal.visited == "Yes" do %>
            <div class="container">
                <div class="field font-semibold">Last Visit :</div>
                <div class="value"><%= @personal.last_visit %></div>
                <div class="value"><.input field={@form[:last_visit]} type="hidden"  value={@personal.last_visit}/></div>
            </div>
            <% end %>

            <div class="container">
                <div class="field font-semibold">Preferred Date :</div>
                <div class="value"><%= @booking.preferred_date %></div>
                <div class="value"><.input field={@form[:preferred_date]} type="hidden"  value={@booking.preferred_date} /></div>
            </div>

            <div class="container">
                <div class="field font-semibold">Alternate Date :</div>
                <div class="value"><%= @booking.alternate_date %></div>
                <div class="value"><.input field={@form[:alternate_date]} type="hidden"  value={@booking.alternate_date} /></div>
            </div>

            <div class="container">
                <div class="field font-semibold">Arrival Date :</div>
                <div class="value"><%= @booking.arrival_date %></div>
                <div class="value"><.input field={@form[:arrival_date]} type="hidden"  value={@booking.arrival_date} /></div>
            </div>

             <div class="container">
                <div class="field font-semibold">Stay :</div>
                <div class="value"><%= @booking.stay %></div>
                <div class="value"><.input field={@form[:stay]} type="hidden"  value={@booking.stay} />
                </div>
            </div>

            <div class="container">
                <div class="field font-semibold">Departure Date :</div>
                <div class="value"><%= @booking.departure_date %></div>
                <div class="value"><.input field={@form[:departure_date]} type="hidden"  value={@booking.departure_date} />
                </div>
            </div>

            <div class="container">
                <div class="field font-semibold">Note :</div>
                <div class="value"><%= @booking.note %></div>
                <div class="value"><.input field={@form[:note]} type="hidden"  value={@booking.note}  />
                </div>
            </div>
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
        EmailNotifier.submission_mail(visitor)

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
