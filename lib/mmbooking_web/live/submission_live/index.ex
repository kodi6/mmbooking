defmodule MmbookingWeb.SubmissionLive.Index do
  use MmbookingWeb, :live_view


  alias Mmbooking.Visitors
  def render(assigns) do
    ~H"""
    <div>
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

             <p class="my-5 text-sm leading-6 text-gray-600">
                NOTE: Submission of booking request does not guarantee a Confirmed booking. Bookings are confirmed as per the availability of seats at the time of processing the requests.
            </p>

            <p class="my-5 text-sm leading-6 text-gray-600">
             <.link class = "underline text-blue-900" navigate={~p"/mmaccess/new_visit/?visitor_email=#{@email}"}>Click here to add a family member using same Email ID</.link>
            </p>

            <p class="my-5 text-sm leading-6 text-gray-600">
                <.link class = "underline text-blue-900" navigate={~p"/mmaccess/visitor_page/personal_details/#{@id}/bookings"}>Click here to view your Bookings</.link>
            </p>
          </div>
    </div>
    """
  end

  def mount(%{"id" => id}, _session, socket) do
    visitor = Visitors.get_visitor_by_id(id)
    email = visitor.email
    update = Visitors.update_visitor(visitor, %{"status" => "Pending"})
    {:ok,
    socket
    |> assign(:email, email)
    |> assign(:id, id)}
  end
end
