defmodule MmbookingWeb.UserLive.Index do
  use MmbookingWeb, :live_view

  alias Mmbooking.Accounts
  alias Mmbooking.Accounts.User


  @impl true
  def mount(params, _session, socket) do
    users = Accounts.list_users
    {:ok,
    socket
    |> assign(:users, users)}
  end


  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:user, %User{})
  end


  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User")
    |> assign(:user, Accounts.get_user!(id))
  end



  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:users, Accounts.list_users)
  end


  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Accounts.get_user!(id)
    {:ok, _} = Accounts.delete_user(user)
    users = Accounts.list_users
    {:noreply,
    socket
    |> assign(:users, users)}
  end

end
