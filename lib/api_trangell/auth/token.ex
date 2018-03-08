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

  # Takes a resource and returns the value that should go into the "sub" field.
  # This is the opposite from resource_from_claims
  def subject_for_token(%{id: id}, _claims) do
      {:ok, to_string(id)}
  end
    # Opposite from subject_for_token. Take the claims and get 
  def resource_from_claims(%{"sub" => id}) do
      {:ok, %{id: id, user: "shahryar"}}
  end

  # Hook into the claims building part to inject permissions into it
  def build_claims(claims, _resource, opts) do
      claims =
        claims
          |> encode_permissions_into_claims!(Keyword.get(opts, :permissions))
          {:ok, claims}
  end
end