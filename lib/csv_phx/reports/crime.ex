defmodule CsvPhx.Reports.Crime do
  use Ecto.Schema
  import Ecto.Changeset


  schema "crimes" do
    field :context, :string
    field :crime_id, :string
    field :crime_type, :string
    field :falls_within, :string
    field :last_outcome_category, :string
    field :latitude, :float
    field :location, :string
    field :longitude, :float
    field :lsoa_code, :string
    field :lsoa_name, :string
    field :month, :string
    field :reported_by, :string

    timestamps()
  end

  @doc false
  def changeset(crime, attrs) do
    crime
    |> cast(attrs, [:crime_id, :month, :reported_by, :falls_within, :longitude, :latitude, :location, :lsoa_code, :lsoa_name, :crime_type, :last_outcome_category, :context])
    |> validate_required([:crime_id, :month, :reported_by])
  end
end
