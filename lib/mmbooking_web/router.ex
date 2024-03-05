defmodule MmbookingWeb.Router do
  use MmbookingWeb, :router

  import MmbookingWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end


  pipeline :liveview do
    plug :put_root_layout, html: {MmbookingWeb.Layouts, :root}
  end

  pipeline :admin do

    plug :put_root_layout, html: {MmbookingWeb.Layouts, :admin_layout}
  end


  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MmbookingWeb do
    pipe_through [:browser, :liveview]

    get "/", PageController, :home
    live "/mmaccess", WelcomeLive.Index, :index
    live "/mmaccess/new_visit", NewVisitorLive.Index, :index
    get "/mmaccess/email", VisitorController, :create
    get "/mmaccess/existing_email", VisitorController, :exist

    live "/mmaccess/submission_successful", SubmissionLive.Index, :index
    live "/mmaccess/visitor_page", VisitorHomeLive.Index, :index
    live "/mmaccess/visitor_page/personal_details/:id", VisitorHomeLive.Show, :show
    live "/mmaccess/visitor_page/personal_details/:id/edit", VisitorHomeLive.Show, :edit
    live "/mmaccess/visitor_page/personal_details/:id/bookings", BookingLive.Index, :index
    live "/mmaccess/visitor_page/personal_details/:id/bookings/new_booking", BookingLive.Index, :edit
    live "/try", TryLive.Index, :index
  end


  scope "/admin", MmbookingWeb do
    pipe_through [:browser, :admin]

    scope "/" do
      pipe_through [:require_authenticated_user]
      live "/", AdminLive.Index, :index
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", MmbookingWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:mmbooking, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MmbookingWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", MmbookingWeb do
    pipe_through [:browser, :admin, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{MmbookingWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", MmbookingWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{MmbookingWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", MmbookingWeb do
    pipe_through [:browser, :admin]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{MmbookingWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
