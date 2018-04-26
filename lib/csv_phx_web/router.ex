defmodule CsvPhxWeb.Router do
  use CsvPhxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CsvPhxWeb do
    pipe_through :browser # Use the default browser stack

    get "/", CrimeController, :index
    resources "/crimes", CrimeController
    get "/search", CrimeController, :search
  end

  # Other scopes may use custom stacks.
  # scope "/api", CsvPhxWeb do
  #   pipe_through :api
  # end
end
