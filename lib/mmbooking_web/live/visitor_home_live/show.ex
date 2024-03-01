defmodule MmbookingWeb.VisitorHomeLive.Show do
  use MmbookingWeb, :live_view


  alias Mmbooking.Visitors

  def mount(%{"id" => id}, _session, socket) do
    visitor = Visitors.get_visitor_by_id(id)
    visitors = Visitors.get_visitors_by_email(visitor.email)
    {:ok,
    socket
    |> assign(:visitor, visitor)
    |> assign(:visitors, visitors)}
  end

  def handle_event("change_name",  %{"id" => id}, socket) do
    visitor = List.first(Enum.filter(socket.assigns.visitors, fn visitor -> visitor.id == id end))
    IO.inspect(visitor, label: "visitor")
    {:noreply,
    socket
    |> assign(:visitor, visitor)
    |> push_patch(to: ~p"/mmaccess/visitor_page/personal_details/#{visitor.id}")
  }
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :show, _params) do
    socket
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User")
    |> assign(:visitor, Visitors.get_visitor_by_id(id))
  end

end
