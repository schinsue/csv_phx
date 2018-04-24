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

  def import(path) do
    path
    |> get_folder_list()
    |> Enum.flat_map(&csv_to_enum_list/1)
  end

  def get_folder_list(path) do
    {:ok, list} = File.ls(path)
    list
  end

  def csv_to_enum_list(date) do
    File.stream!("./data/#{date}/#{date}-city-of-london-street.csv")
    |> CSV.decode!(seperator: ',', headers: true)
    |> Enum.to_list()
  end

end

DBSeed.import("./data/")