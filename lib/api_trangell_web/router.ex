defmodule ApiTrangellWeb.Router do
  use ApiTrangellWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :unauthorized do
    plug :fetch_session
  end

  pipeline :authorized do
    plug :fetch_session
    plug Guardian.Plug.Pipeline, module: ApiTrangell.Guardian,
      error_handler: ApiTrangell.AuthErrorHandler
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  scope "/api", ApiTrangellWeb do
    pipe_through :api

    scope "/users" do
      scope "/" do
        pipe_through :unauthorized
  
        post "/sign-in", PageController, :sign_in
        post "/kab", PageController, :kab
      end
  
      scope "/" do
        pipe_through :authorized
  
        post "/sign-out", PageController, :sign_out
        post "/me", PageController, :show
      end
    end
  end
  # Other scopes may use custom stacks.
  # scope "/api", ApiTrangellWeb do
  #   pipe_through :api
  # end
end
