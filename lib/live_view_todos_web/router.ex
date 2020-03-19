defmodule LiveViewTodosWeb.Router do
  use LiveViewTodosWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
    plug :put_layout, {LiveViewTodosWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveViewTodosWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/count" , CounterLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveViewTodosWeb do
  #   pipe_through :api
  # end
end
