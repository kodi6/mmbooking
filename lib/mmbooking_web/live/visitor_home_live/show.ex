defmodule MmbookingWeb.VisitorHomeLive.Show do
  use MmbookingWeb, :live_view


  alias Mmbooking.Visitors
  def mount(params, _session, socket) do
    id = Map.get(params, "id")
    visitor = Visitors.get_visitor_by_id(id)
    visitors = Visitors.get_visitors_by_email(visitor.email)
    {:ok,
    socket
    |> assign(:visitor, visitor)
    |> assign(:visitors, visitors)
  }
  end




  def handle_event("change_name", %{"first_name" => first_name}, socket) do
    visitor = List.first(Enum.filter(socket.assigns.visitors, fn visitor -> visitor.first_name == first_name end))



    {:noreply,
    socket
    |> assign(:visitor, visitor)
  }
  end
end
