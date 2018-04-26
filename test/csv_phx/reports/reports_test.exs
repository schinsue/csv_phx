defmodule CsvPhx.ReportsTest do
  use CsvPhx.DataCase

  alias CsvPhx.Reports

  describe "crimes" do
    alias CsvPhx.Reports.Crime

    @valid_attrs %{context: "some context", crime_id: "some crime_id", crime_type: "some crime_type", falls_within: "some falls_within", last_outcome_category: "some last_outcome_category", latitude: 120.5, location: "some location", longitude: 120.5, lsoa_code: "some lsoa_code", lsoa_name: "some lsoa_name", month: "some month", reported_by: "some reported_by"}
    @update_attrs %{context: "some updated context", crime_id: "some updated crime_id", crime_type: "some updated crime_type", falls_within: "some updated falls_within", last_outcome_category: "some updated last_outcome_category", latitude: 456.7, location: "some updated location", longitude: 456.7, lsoa_code: "some updated lsoa_code", lsoa_name: "some updated lsoa_name", month: "some updated month", reported_by: "some updated reported_by"}
    @invalid_attrs %{context: nil, crime_id: nil, crime_type: nil, falls_within: nil, last_outcome_category: nil, latitude: nil, location: nil, longitude: nil, lsoa_code: nil, lsoa_name: nil, month: nil, reported_by: nil}

    def crime_fixture(attrs \\ %{}) do
      {:ok, crime} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reports.create_crime()

      crime
    end

    test "list_crimes/0 returns all crimes" do
      crime = crime_fixture()
      assert Reports.list_crimes() == [crime]
    end

    test "get_crime!/1 returns the crime with given id" do
      crime = crime_fixture()
      assert Reports.get_crime!(crime.id) == crime
    end

    test "create_crime/1 with valid data creates a crime" do
      assert {:ok, %Crime{} = crime} = Reports.create_crime(@valid_attrs)
      assert crime.context == "some context"
      assert crime.crime_id == "some crime_id"
      assert crime.crime_type == "some crime_type"
      assert crime.falls_within == "some falls_within"
      assert crime.last_outcome_category == "some last_outcome_category"
      assert crime.latitude == 120.5
      assert crime.location == "some location"
      assert crime.longitude == 120.5
      assert crime.lsoa_code == "some lsoa_code"
      assert crime.lsoa_name == "some lsoa_name"
      assert crime.month == "some month"
      assert crime.reported_by == "some reported_by"
    end

    test "create_crime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reports.create_crime(@invalid_attrs)
    end

    test "update_crime/2 with valid data updates the crime" do
      crime = crime_fixture()
      assert {:ok, crime} = Reports.update_crime(crime, @update_attrs)
      assert %Crime{} = crime
      assert crime.context == "some updated context"
      assert crime.crime_id == "some updated crime_id"
      assert crime.crime_type == "some updated crime_type"
      assert crime.falls_within == "some updated falls_within"
      assert crime.last_outcome_category == "some updated last_outcome_category"
      assert crime.latitude == 456.7
      assert crime.location == "some updated location"
      assert crime.longitude == 456.7
      assert crime.lsoa_code == "some updated lsoa_code"
      assert crime.lsoa_name == "some updated lsoa_name"
      assert crime.month == "some updated month"
      assert crime.reported_by == "some updated reported_by"
    end

    test "update_crime/2 with invalid data returns error changeset" do
      crime = crime_fixture()
      assert {:error, %Ecto.Changeset{}} = Reports.update_crime(crime, @invalid_attrs)
      assert crime == Reports.get_crime!(crime.id)
    end

    test "delete_crime/1 deletes the crime" do
      crime = crime_fixture()
      assert {:ok, %Crime{}} = Reports.delete_crime(crime)
      assert_raise Ecto.NoResultsError, fn -> Reports.get_crime!(crime.id) end
    end

    test "change_crime/1 returns a crime changeset" do
      crime = crime_fixture()
      assert %Ecto.Changeset{} = Reports.change_crime(crime)
    end

    test "search_crime_by_location returns crime on search" do
      crime = crime_fixture()
      assert [crime] == Reports.search_crimes_by_location(crime.location)
    end

    test "search_crime_by_location is case insensitive" do
      crime = crime_fixture()
      location = crime.location |> String.upcase()
      assert [crime] == Reports.search_crimes_by_location(location)
    end
  end
end
