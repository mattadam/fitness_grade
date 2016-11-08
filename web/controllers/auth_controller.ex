defmodule OAuth2Example.AuthController do
  use FitnessGrade.Web, :controller
  alias FitnessGrade.OAuth2

  def index(conn, %{"provider" => provider}) do
    redirect conn, external: authorize_url!(provider)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end


  def callback(conn, %{"provider" => provider, "code" => code}) do
    client = Fitbit.get_token!(code: code)
    user = get_user!(provider, client)

    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
  end

  defp authorize_url!("fitbit"),   do: Fitbit.authorize_url!
  defp authorize_url!(_), do: raise "No matching provider available"

  defp get_token!("fitbit", code),   do: Fitbit.get_token!(code: code)
  defp get_token!(_, _), do: raise "No matching provider available"

  defp get_user!("fitbit", client) do
    response = Fitbit.get(client, "/1/user/-/profile.json").body["user"]

    %{user: response["fullName"]}
  end
end
