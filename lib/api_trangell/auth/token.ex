defmodule ApiTrangell.Auth.Token do

  use Guardian, otp_app: :api_trangell,
                         permissions: %{
                         default: [:public_profile, :user_about_me],
                         user_actions: %{
                           books: 0b1,
                           fitness: 0b100,
                           music: 0b1000,
                         }
                       }

  use Guardian.Permissions.Bitwise

  # snip

  def build_claims(claims, _resource, opts) do
    claims =
      claims
      |> encode_permissions_into_claims!(Keyword.get(opts, :permissions))
    {:ok, claims}
  end
end