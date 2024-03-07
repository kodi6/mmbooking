defmodule MmbookingWeb.SearchVisitorLive.Index do
  use MmbookingWeb, :live_view


  alias Mmbooking.Visitors
  alias Mmbooking.Visitor.Visitor

  def mount(_params, _session, socket) do
    visitors = Visitors.list_visitor
    {:ok,
    socket
    |> assign(:visitors, [])}
  end


  def handle_event("search", params, socket) do
    visitors = Visitors.search_visitors(params)
    {:noreply,
    socket
    |> assign(:visitors, visitors)}
  end


  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end


  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:visitor, %Visitor{})
  end

  defp apply_action(socket, :index, _params) do
    socket

  end

end
