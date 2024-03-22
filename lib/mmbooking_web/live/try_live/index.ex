defmodule MmbookingWeb.TryLive.Index do
  use MmbookingWeb, :live_view



  def mount(params, session, socket) do
      lists = [
        %{monday: [["Eco Service 1", "Eco Service 2", "Purnam"]]},
        %{tuesday: [["Eco ", "Ecoooo"]]},
        %{wednesday: [["talam"]]},
        %{thursday: [["yhf"]]},
        %{friday: [["ddsjb", "beje"]]},
        %{saturday: [["gvhd", "jhggh"]]}
      ]

    {:ok,
    socket
    |> assign(:lists, lists)
  }
  end
end
