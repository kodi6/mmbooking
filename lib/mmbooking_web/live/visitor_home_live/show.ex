defmodule MmbookingWeb.VisitorHomeLive.Show do
  use MmbookingWeb, :live_view


  alias Mmbooking.Visitors
  def mount(params, _session, socket) do
    id = Map.get(params, "id")
    visitor = Visitors.get_visitor_by_id(id)
    {:ok,
    socket
    |> assign(:visitor, visitor)
  }
  end
end
