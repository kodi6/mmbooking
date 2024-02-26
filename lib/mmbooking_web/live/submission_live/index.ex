defmodule MmbookingWeb.SubmissionLive.Index do
  use MmbookingWeb, :live_view


  alias Mmbooking.Visitors
  def render(assigns) do
    ~H"""
    <div>
    <div class="bg-white">
        <div class="mx-auto max-w-7xl">
          <div class="text-left">
            <h2 class="text-2xl font-bold tracking-tight text-title_txt">Submission Report</h2>
            <p class="my-5 text-sm leading-6 text-gray-600">
              Your request for booking has been successfully submitted.
            </p>
            <p class="my-5 text-sm leading-6 text-gray-600">
              An Email acknowledging your submission will be sent to your registered Email ID.
            </p>
            <p class="my-5 text-sm leading-6 text-gray-600">
              Your request for booking will be processed within 72 hours.  If you do not receive an email confirmation, you can write to us at mmconcentration@auroville.org.in.
            </p>

          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(%{"id" => id}, _session, socket) do

    visitor = Visitors.get_visitor_by_id(id)
    IO.inspect(visitor, label: "visitor")
    update = Visitors.update_changeset(visitor, %{"status" => "Request sent"})
    IO.inspect(update, label: "update")
    {:ok, socket}
  end
end
