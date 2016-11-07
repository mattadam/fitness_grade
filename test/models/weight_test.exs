defmodule FitnessGrade.WeightTest do
  use FitnessGrade.ModelCase

  alias FitnessGrade.Weight

  @valid_attrs %{bmi: "120.5", date: "some content", weight: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Weight.changeset(%Weight{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Weight.changeset(%Weight{}, @invalid_attrs)
    refute changeset.valid?
  end
end
