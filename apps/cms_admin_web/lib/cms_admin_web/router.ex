defmodule CmsAdminWeb.Router do
  use CmsAdminWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CmsAdminWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", CmsAdminWeb do
    pipe_through :browser
    get "/", PageController, :home
  end
end
