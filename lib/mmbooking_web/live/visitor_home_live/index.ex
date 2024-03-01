defmodule MmbookingWeb.VisitorHomeLive.Index do
  use MmbookingWeb, :live_view

alias Mmbooking.Visitors

  def mount(_params, %{"visitor_email" => visitor_email}, socket) do
    visitors = Visitors.get_visitors_by_email(visitor_email)
    {:ok,
    socket
    |> assign(:visitor_email, visitor_email)
    |> assign(:visitors, visitors)
  }
  end


  def handle_event("radio", %{"id" => id}, socket) do
    {:noreply,
    socket
    |> redirect(to: ~p"/mmaccess/visitor_page/personal_details/#{id}/bookings")}
  end

end
