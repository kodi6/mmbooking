defmodule MmbookingWeb.SearchVisitorLive.Index do
  use MmbookingWeb, :live_view


  alias Mmbooking.Visitors

  def mount(params, _session, socket) do
    visitors = Visitors.list_visitor
    IO.inspect(visitors, label: "visitors1")
    {:ok,
    socket
    |> assign(:visitors, [])
  }
  end


  def handle_event("search", params, socket) do
    visitors = Visitors.search_visitors(params)
    IO.inspect(visitors, label: "visitors2")


    {:noreply,
    socket
    |> assign(:visitors, visitors)}
  end
end
