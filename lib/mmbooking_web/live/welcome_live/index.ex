defmodule MmbookingWeb.WelcomeLive.Index do
  use MmbookingWeb, :live_view


  alias Mmbooking.Visitors



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
        |> push_redirect(to: ~p"/mmaccess/existing_email/?visitor_email=#{email}")
        |> assign(:email, email)}
      else
        {:noreply,
        socket
        |> push_redirect(to: ~p"/mmaccess/email/?visitor_email=#{email}")
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
