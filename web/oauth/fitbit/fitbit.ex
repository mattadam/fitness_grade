defmodule Fitbit do
  use OAuth2.Strategy

  # Public API

  def client do
    OAuth2.Client.new([
      strategy: __MODULE__,
      client_id: Application.fetch_env!(:plug, :fitbit_client_id),
      client_secret: Application.fetch_env!(:plug, :fitbit_client_secret),
      redirect_uri: "http://localhost:4000/auth/fitbit/callback",
      site: "https://api.fitbit.com",
      authorize_url: "https://www.fitbit.com/oauth2/authorize",
      token_url: "https://api.fitbit.com/oauth2/token",
      headers: [{"authorization", "Basic " <> Base.encode64(Application.fetch_env!(:plug, :fitbit_client_id) <> ":" <> Application.fetch_env!(:plug, :fitbit_client_secret))} ]
      ])
    end

    def authorize_url! do
      OAuth2.Client.authorize_url!(client(), scope: "profile weight")
    end

    def get_token!(params) do
      OAuth2.Client.get_token!(client(), Keyword.merge(params, grant_type: "authorization_code"), client().headers)
    end

    def authorize_url(client, params) do
      OAuth2.Strategy.AuthCode.authorize_url(client, params)
    end

    def get_token(client, params, headers) do
      client
      |> put_header("accept", "application/json")
      |> OAuth2.Strategy.AuthCode.get_token(params, headers)
    end

    def get(client, url) do
      OAuth2.Client.get!(client, url)
    end
  end
