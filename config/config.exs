# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api_trangell,
  ecto_repos: [ApiTrangell.Repo]

# Configures the endpoint
config :api_trangell, ApiTrangellWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "armzj2z187kzQsSmPyaQc1XspeKJNQaIl88byYjBcW5PECxDM2OkQKZdAz7A/064",
  render_errors: [view: ApiTrangellWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ApiTrangell.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.


# config :api_trangell, ApiTrangell.Guardian,
#        issuer: "api_trangell",
#        secret_key: "4iHJhbnkuxDrhNG52ViAf1np/O6YSv0zyGAuNjXg5d0kArcpFvt+/L5cW3f6f15G"

# config :api_trangell, ApiTrangell.Guardian,
#   issuer: "api_trangell",
#   allowed_algos: ["ES512"],
#   secret_key: %{
#     "alg" => "ES512",
#     "crv" => "P-521",
#     "d" => "5lzq86dlBivEqOmJj_6x_xW5lxY5bCAV1cxJ1Lt8fsshKAkHOz3j0iOF_ruG2PYXF69kDnY3HvSiY2tbog2UjBc",
#     "kty" => "EC",
#     "use" => "sig",
#     "x" => "AIYZCBlSZ4jGvRHJnhWU_s85Uqu6Fl8F7TMMD1WjcibHIGIHfPjEwyfIdmAjvgMwKalqjhKIgqQEejvaPtxHwLMB",
#     "y" => "AOogDP-U1x4VcgL0xUr7TEXc9FmQv3wvJ_goDW6ZJ_1PBebpOVltZP-3ydG1nAr-ddqoq9AFUQP9UhY3wQhvKFD_"
#   }

  config :api_trangell, ApiTrangell.Guardian,
    issuer: "api_trangell",
    allowed_algos: ["HS256"],
    secret_key: %{
      "alg" => "HS256",
      "k" => "oi1T_d3HenJGPO1enhwAb7bUWaAtTMTfVi0LhkfnA0E",
      "kty" => "oct",
      "use" => "sig",
    }

import_config "#{Mix.env}.exs"