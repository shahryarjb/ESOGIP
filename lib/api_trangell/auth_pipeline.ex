defmodule ApiTrangell.AuthPipeline do
	@claims %{typ: "access"}  
  use Guardian.Plug.Pipeline, otp_app: :api_trangell,
                              module: ApiTrangell.Guardian,
                              error_handler: ApiTrangell.AuthErrorHandler

  plug Guardian.Permissions.Bitwise, ensure: %{default: [:public_profile], user_actions: [:books]}
  plug Guardian.Plug.VerifySession, claims: @claims
  plug Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, ensure: true
  # json VerifyHeader
  # plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  # plug Guardian.Plug.LoadResource, ensure: true, allow_blank: true
end