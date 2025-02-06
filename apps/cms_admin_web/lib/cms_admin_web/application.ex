defmodule CmsAdminWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CmsAdminWeb.Telemetry,
      # CmsAdmin.Repo,
      {DNSCluster, query: Application.get_env(:cms_admin, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CmsAdmin.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CmsAdmin.Finch},
      # Start a worker by calling: CmsAdmin.Worker.start_link(arg)
      # {CmsAdmin.Worker, arg},
      # Start to serve requests, typically the last entry
      CmsAdminWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CmsAdminWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CmsAdminWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
