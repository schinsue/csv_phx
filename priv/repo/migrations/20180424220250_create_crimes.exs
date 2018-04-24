defmodule CsvPhx.Repo.Migrations.CreateCrimes do
  use Ecto.Migration

  def change do
    create table(:crimes) do
      add :crime_id, :string
      add :month, :string
      add :reported_by, :string
      add :falls_within, :string
      add :longitude, :float
      add :latitude, :float
      add :location, :string
      add :lsoa_code, :string
      add :lsoa_name, :string
      add :crime_type, :string
      add :last_outcome_category, :text
      add :context, :string

      timestamps()
    end

  end
end
