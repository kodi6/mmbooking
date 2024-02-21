defmodule MmbookingWeb.WelcomeLive.Index do
  use MmbookingWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
    <.simple_form
        :let={f}
        for={:email_form}
        id="email-form"
      >
        <.input field={{f, :email}} type="email" name="email" value="" label="Email" />
        <.input field={{f, :email}} type="checkbox" name="email" value="" label="I Agree to Report between 8:15am to 8:30am" />


        <:actions>
          <.button phx-disable-with="Saving...">Proceed</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end



end
