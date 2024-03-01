defmodule MmbookingWeb.VisitorHomeLive.Index do
  use MmbookingWeb, :live_view

alias Mmbooking.Visitors

  def mount(%{"id" => id}, _session, socket) do
    visitor = Visitors.get_visitor_by_id(id)
    visitors = Visitors.get_visitors_by_email(visitor.email)
    {:ok,
    socket
    |> assign(:visitor, visitor)
    |> assign(:visitors, visitors)
  }
  end


  def handle_event("radio", %{"id" => id}, socket) do
    {:noreply,
    socket
    |> redirect(to: ~p"/mmaccess/visitor_page/personal_details/#{id}/bookings")}
  end

end
