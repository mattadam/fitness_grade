defmodule FitnessGrade.PageController do
  use FitnessGrade.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
