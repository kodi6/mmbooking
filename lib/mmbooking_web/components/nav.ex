defmodule MmbookingWeb.Nav do
  use Phoenix.Component


  def navbar(assigns) do
    ~H"""
      <div>

          <div class=" flex items-center justify-between bg-blue-200">
            <a class="flex content-center p-3 font-sueEllenFrancisco text-4xl">Matrimandir</a>

            <ul class="relative z-10 flex items-center gap-4 px-4 sm:px-6 lg:px-8 justify-end">
            <%= if @current_user do %>
              <li class="text-[0.8125rem] leading-6 text-zinc-900">
                <%= @current_user.email %>
              </li>
              <li>
                <.link
                  href="/users/settings"
                  class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
                >
                  Settings
                </.link>
              </li>
              <li>
                <.link
                  href="/users/log_out"
                  method="delete"
                  class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
                >
                  Log out
                </.link>
              </li>
            <% end %>
          </ul>

        </div>
      </div>
    """
  end

end
