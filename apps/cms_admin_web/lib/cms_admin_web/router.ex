defmodule CmsAdminWeb.Router do
  use CmsAdminWeb, :router

  use Beacon.LiveAdmin.Router

  pipeline :beacon_admin do
    plug Beacon.LiveAdmin.Plug
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CmsAdminWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/" do
    pipe_through [:browser, :beacon_admin]
    beacon_live_admin "/admin"
  end

  scope "/", CmsAdminWeb do
    pipe_through :browser
    get "/", PageController, :home
  end
end
