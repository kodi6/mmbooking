defmodule MmbookingWeb.BookingDetailLive.Index do
  use MmbookingWeb, :live_view


  alias Mmbooking.Visitors
  alias Mmbooking.EmailNotifier

  def mount(%{"id" => id}, _session, socket) do
    visitor = Visitors.get_visitor_by_id(id)
    {:ok,
    socket
    |> assign(:visitor, visitor)}
  end


  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User")
    |> assign(:visitor, Visitors.get_visitor_by_id(id))
  end

  defp apply_action(socket, :custom_email, _params) do
    socket
    |> assign(:page_title, "Send email")
    |> assign(:visitor, socket.assigns.visitor)
  end


  def handle_event("delete", %{"id" => id}, socket) do
    visitor = Visitors.get_visitor_by_id(id)
    {:ok, _} = Visitors.delete_visitor(visitor)

    {:noreply,
    socket
    |> assign(:visitor, visitor)}
  end


  def handle_event("link", _params, socket) do
    visitor = socket.assigns.visitor
    IO.inspect(visitor, label: "visitor")
    EmailNotifier.send_link(visitor)
    {:noreply, socket}
  end

end
