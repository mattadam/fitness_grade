defmodule FitnessGrade.WeightControllerTest do
  use FitnessGrade.ConnCase

  alias FitnessGrade.Weight
  @valid_attrs %{bmi: "120.5", date: "some content", weight: "120.5"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, weight_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    weight = Repo.insert! %Weight{}
    conn = get conn, weight_path(conn, :show, weight)
    assert json_response(conn, 200)["data"] == %{"id" => weight.id,
      "bmi" => weight.bmi,
      "date" => weight.date,
      "weight" => weight.weight}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, weight_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, weight_path(conn, :create), weight: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Weight, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, weight_path(conn, :create), weight: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    weight = Repo.insert! %Weight{}
    conn = put conn, weight_path(conn, :update, weight), weight: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Weight, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    weight = Repo.insert! %Weight{}
    conn = put conn, weight_path(conn, :update, weight), weight: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    weight = Repo.insert! %Weight{}
    conn = delete conn, weight_path(conn, :delete, weight)
    assert response(conn, 204)
    refute Repo.get(Weight, weight.id)
  end
end
