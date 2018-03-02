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
    plug ApiTrangell.AuthPipeline
  end

  scope "/api/users", ApiTrangellWeb do
    pipe_through :api
    pipe_through :unauthorized
    post "/sign-in", PageController, :sign_in
    post "/verify-token", PageController, :verify_token
    post "/refresh-token", PageController, :refresh_token
  end

  scope "/api/users", ApiTrangellWeb do
    pipe_through :api
    pipe_through :authorized
    post "/sign-out", PageController, :sign_out
    post "/me", PageController, :show
  end
end
