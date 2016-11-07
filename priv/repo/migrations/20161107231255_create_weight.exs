defmodule FitnessGrade.Repo.Migrations.CreateWeight do
  use Ecto.Migration

  def change do
    create table(:weights) do
      add :bmi, :float
      add :date, :string
      add :weight, :float

      timestamps()
    end

  end
end
