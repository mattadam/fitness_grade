defmodule FitnessGrade.Weight do
  use FitnessGrade.Web, :model

  schema "weights" do
    field :bmi, :float
    field :date, :string
    field :weight, :float

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:bmi, :date, :weight])
    |> validate_required([:bmi, :date, :weight])
  end
end
