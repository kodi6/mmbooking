defmodule MmbookingWeb.SearchVisitorLive.AddVisitorFormComponent do
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
          <.custom_input field={@form[:email]} type="email"  label="Email" />
          <.custom_input field={@form[:first_name]} type="text" label="First Name" required />
          <.custom_input field={@form[:last_name]} type="text" label="Last Name" required />
          <.custom_input field={@form[:dob]} type="date" label="Dob Of Birth"  required />
          <.custom_input field={@form[:country]} type="select" label="Country" prompt="Select Country" options={Enum.map(Countries.all, fn country -> country.name end)} required />
          <.custom_input field={@form[:city]} type="text" label="City" required />

          <:actions>
            <.button phx-disable-with="Saving...">Submit</.button>
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

  @impl true
  def handle_event("validate", %{"visitor" => visitor_params}, socket) do
    changeset =
      socket.assigns.visitor
      |> Visitors.change_personal_changeset(visitor_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end



  @impl true
  def handle_event("save", %{"visitor" => visitor_params}, socket) do
    case Visitors.create_visitor(visitor_params) do
      {:ok, visitor} ->

        {:noreply,
         socket
         |> put_flash(:info, "User created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

end
