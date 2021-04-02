use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :find_my_personal, FindMyPersonal.Repo,
  username: "postgres",
  password: "postgres",
  database: "find_my_personal_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "192.168.15.88",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :find_my_personal, FindMyPersonalWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn