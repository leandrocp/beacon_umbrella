# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :cms_admin_web,
  ecto_repos: [CmsAdminWeb.Repo],
  generators: [context_app: false]

# Configures the endpoint
config :cms_admin_web, CmsAdminWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: CmsAdminWeb.ErrorHTML, json: CmsAdminWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: CmsAdminWeb.PubSub,
  live_view: [signing_salt: "SKZPQrQq"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  cms_admin_web: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/cms_admin_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  cms_admin_web: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/cms_admin_web/assets", __DIR__)
  ]

# Configure Mix tasks and generators
config :big_app,
  ecto_repos: [BigApp.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :big_app, BigApp.Mailer, adapter: Swoosh.Adapters.Local

config :big_app_web,
  ecto_repos: [BigApp.Repo],
  generators: [context_app: :big_app]

# Configures the endpoint
config :big_app_web, BigAppWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: BigAppWeb.ErrorHTML, json: BigAppWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: BigApp.PubSub,
  live_view: [signing_salt: "LSaQ5jDv"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  big_app_web: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/big_app_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  big_app_web: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/big_app_web/assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
