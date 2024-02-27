defmodule MmbookingWeb.BookingLive.Index do
  use MmbookingWeb, :live_view

  alias Mmbooking.Visitors

  def mount(%{"id" => id}, _session, socket) do
    visitor = Visitors.get_visitor_by_id(id)
    {:ok,
    socket
    |> assign(:visitor, visitor)}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, _params) do
    visitor = socket.assigns.visitor
    socket
    |> assign(:page_title, "New booking")
    |> assign(:visitor, visitor)
  end

  defp apply_action(socket, :index, _params) do
    socket
  end

end
