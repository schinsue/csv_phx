use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :csv_phx, CsvPhxWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :csv_phx, CsvPhx.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "csv_phx_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
