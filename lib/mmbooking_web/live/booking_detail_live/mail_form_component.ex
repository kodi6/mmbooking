defmodule MmbookingWeb.BookingDetailLive.MailFormComponent do
  use MmbookingWeb, :live_component

  alias Mmbooking.EmailNotifier


  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to send message to the visitor.</:subtitle>
      </.header>

      <.simple_form
        for={:form}
        :let={f}
        id="user-form"
        phx-target={@myself}
        phx-submit="send"
      >
        <.input field={f[:subject]} type="text" label="Subject" />
        <.input field={f[:message]} type="textarea" label="Message" />
        <:actions>
          <.button phx-disable-with="Saving...">Send</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end


  @impl true
  def update(assigns, socket) do
   {:ok,
    socket
    |> assign(assigns)}
  end

  @impl true
  def handle_event("send", %{"form" => %{"message" => message, "subject" => subject}}, socket) do
    visitor = socket.assigns.visitor
    EmailNotifier.custom_mail(subject, message, visitor)
    {:noreply,
    socket
    |> push_patch(to: socket.assigns.patch)
   }
  end
end
