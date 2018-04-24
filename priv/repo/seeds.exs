# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CsvPhx.Repo.insert!(%CsvPhx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule DBSeed do
  alias CsvPhx.Reports

  def import(path) do
    path
    |> get_folder_list()
    |> Enum.flat_map(&csv_to_enum_list/1)
    |> Enum.map(&convert_to_schema/1)
    |> Task.async_stream(&Reports.create_crime/1, [max_concurrency: 10_000])
    |> Enum.map(fn {:ok, x} -> x end)
  end

  defp get_folder_list(path) do
    {:ok, list} = File.ls(path)
    list
  end

  defp csv_to_enum_list(date) do
    File.stream!("./data/#{date}/#{date}-city-of-london-street.csv")
    |> CSV.decode!(seperator: ',', headers: true)
    |> Enum.to_list()
  end

  defp convert_to_schema(crime) do
    %{
      context: crime["Context"],
      crime_id: crime["Crime ID"],
      crime_type: crime["Crime type"],
      falls_within: crime["Falls within"],
      last_outcome_category: crime["Last outcome category"],
      latitude: crime["Latitude"] |> parse_float(),
      location: crime["Location"],
      longitude: crime["Longitude"] |> parse_float(),
      lsoa_code: crime["LSOA code"],
      lsoa_name: crime["LSOA name"],
      month: crime["Month"],
      reported_by: crime["Reported by"],
    }
  end

  defp parse_float(""), do: 0
  defp parse_float(string) do
    {float, _} = string |> Float.parse()
    float
  end
end

DBSeed.import("./data/")