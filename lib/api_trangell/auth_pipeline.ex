defmodule ApiTrangell.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :api_trangell,
                              module: ApiTrangell.Tokens,
                              error_handler: ApiTrangell.AuthErrorHandler

  plug Guardian.Plug.VerifySession, claims: @claims
  plug Guardian.Plug.VerifyHeader, claims: %{typ: "refresh"}, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, ensure: true
end