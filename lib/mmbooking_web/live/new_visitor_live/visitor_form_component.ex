defmodule MmbookingWeb.NewVisitorLive.VisitorFormComponent do
  use MmbookingWeb, :live_component

  alias Mmbooking.Visitors
  alias Mmbooking.Visitor.Visitor

  def render(assigns) do
    ~H"""
    <div>
      <.simple_form
          for={@form}
          phx-target={@myself}
          phx-change="validate"
          phx-submit="save"
        >
          <.input field={@form[:email]} type="email" label="email" value={@visitor_email} />
          <.input field={@form[:first_name]} type="text" label="First Name" value="gfiugrir" required />
          <.input field={@form[:last_name]} type="text" label="Last Name" value="gfiugrir" required />
          <.input field={@form[:dob]} type="date" label="Dob Of Birth"  required />
          <.input field={@form[:country]} type="text" label="Country" value="gfiugrir" required />
          <.input field={@form[:city]} type="text" label="City" value="gfiugrir" required />

          <.input field={@form[:visited]}
            type="select"
            label="Visited?"
            prompt="Select one"
            options={[{"Yes", "Yes"}, {"No", "no"}]}
            required
          />
            <%= if @is_visited? do %>
          <.input field={@form[:last_visit]} type="text" label="Last visit" value="may 20" required/>

            <% end %>


          <:actions>
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
     |> assign_form(assigns.personal_changeset)
     }
  end


  @impl true
  def handle_event("validate", %{"visitor" => visitor_params}, socket) do
    personal_changeset =
      socket.assigns.visitor
      |> Visitors.change_step1_changeset(visitor_params)
      |> Map.put(:action, :validate)

      visited = Map.get(visitor_params, "visited")

      visited = case visited do
        "Yes" -> true
        _-> false
      end


    {:noreply,
    socket
    |> assign(:is_visited?, visited)
    |> assign_form(personal_changeset)}
  end


  @impl true
  def handle_event("save", %{"visitor" => visitor_params}, socket) do
    personal_changeset =
      socket.assigns.visitor
      |> Visitors.change_step1_changeset(visitor_params)
      |> Map.put(:action, :validate)

      send(self(), {:update_step, 1})
      send(self(), {:update_personal_changeset, personal_changeset})

    {:noreply, assign_form(socket, personal_changeset)}
  end





  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

end
