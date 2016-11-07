defmodule FitnessGrade.WeightView do
  use FitnessGrade.Web, :view

  def render("index.json", %{weights: weights}) do
    %{data: render_many(weights, FitnessGrade.WeightView, "weight.json")}
  end

  def render("show.json", %{weight: weight}) do
    %{data: render_one(weight, FitnessGrade.WeightView, "weight.json")}
  end

  def render("weight.json", %{weight: weight}) do
    %{id: weight.id,
      bmi: weight.bmi,
      date: weight.date,
      weight: weight.weight}
  end
end
