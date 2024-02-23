defmodule MmbookingWeb.WelcomeLive.Index do
  use MmbookingWeb, :live_view


  alias Mmbooking.Visitors

  def render(assigns) do
    ~H"""
    <div>
      <.simple_form :let={f} for={:email_form} id="email-form" phx-submit="save">
      <.input name="email" field={{f, :email}} type="email"  value={@email}  placeholder="Email address" required/>
      <.input name="checkbox" type="checkbox" />
      <%= if @is_selected do %>
      <.warning_message message="People who can report at the Auroville Visitor Center between 8:15 to 8:30 am can only request a booking.">
      </.warning_message>
      <% end %>
      <.button  phx-disable-with="Saving...">Get form</.button>
      </.simple_form>
    </div>
    """
  end


  def mount(_params, _session, socket) do
    {:ok,
    socket
    |> assign(:is_selected, false)
    |> assign(:email, nil)}
  end

  def handle_event("save", %{"checkbox" => checkbox, "email" => email}, socket) do
    if checkbox == "true" do
      emails = Visitors.list_email
      if email in emails do
        {:noreply,
        socket
        |> push_redirect(to: ~p"/mmaccess/visitor_page")
        |> assign(:email, email)}
      else
        {:noreply,
        socket
        |> push_redirect(to: ~p"/mmaccess/new_visit/?visitor_email=#{email}")
        |> assign(:email, email)}
      end

    else
      {:noreply,
        socket
        |> assign(:is_selected, true)
        |> assign(:email, email)}
    end
  end

end
