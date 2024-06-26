defmodule MmbookingWeb.NewVisitorLive.Index do
  use MmbookingWeb, :live_view


  alias Mmbooking.Visitor.Visitor
  alias Mmbooking.Visitors


  @impl true
  def mount(_params, %{"visitor_email" => visitor_email}, socket) do
    changeset = Visitors.change_visitor(%Visitor{})

    {:ok,
    socket
    |> assign(:is_visited?, false)
    |> assign(:step, 0)
    |> assign(:visitor, %Visitor{})
    |> assign(:personal_changeset, changeset)
    |> assign(:booking_changeset, changeset)
    |> assign(:preview_changeset, changeset)
    |> assign(:visitor_email, visitor_email)}
  end


  def handle_info({:update_step, step}, socket) do
    {:noreply,
     socket
     |> assign(:step, step)}
  end

  @impl true
  def handle_info({:update_personal_changeset, changeset}, socket) do
    {:noreply,
     socket
     |> assign(:personal_changeset, changeset)}
  end

  @impl true
  def handle_info({:update_booking_changeset, changeset}, socket) do
    {:noreply,
     socket
     |> assign(:booking_changeset, changeset)}
  end

end
