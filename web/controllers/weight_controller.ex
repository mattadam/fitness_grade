defmodule FitnessGrade.WeightController do
  use FitnessGrade.Web, :controller

  alias FitnessGrade.Weight

  def index(conn, _params) do
    weights = Repo.all(Weight)
    render(conn, "index.json", weights: weights)
  end

  def create(conn, %{"weight" => weight_params}) do
    changeset = Weight.changeset(%Weight{}, weight_params)

    case Repo.insert(changeset) do
      {:ok, weight} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", weight_path(conn, :show, weight))
        |> render("show.json", weight: weight)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FitnessGrade.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    weight = Repo.get!(Weight, id)
    render(conn, "show.json", weight: weight)
  end

  def update(conn, %{"id" => id, "weight" => weight_params}) do
    weight = Repo.get!(Weight, id)
    changeset = Weight.changeset(weight, weight_params)

    case Repo.update(changeset) do
      {:ok, weight} ->
        render(conn, "show.json", weight: weight)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FitnessGrade.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    weight = Repo.get!(Weight, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(weight)

    send_resp(conn, :no_content, "")
  end
end
