defmodule CsvPhxWeb.CrimeControllerTest do
  use CsvPhxWeb.ConnCase

  alias CsvPhx.Reports

  @create_attrs %{context: "some context", crime_id: "some crime_id", crime_type: "some crime_type", falls_within: "some falls_within", last_outcome_category: "some last_outcome_category", latitude: 120.5, location: "some location", longitude: 120.5, lsoa_code: "some lsoa_code", lsoa_name: "some lsoa_name", month: "some month", reported_by: "some reported_by"}
  @update_attrs %{context: "some updated context", crime_id: "some updated crime_id", crime_type: "some updated crime_type", falls_within: "some updated falls_within", last_outcome_category: "some updated last_outcome_category", latitude: 456.7, location: "some updated location", longitude: 456.7, lsoa_code: "some updated lsoa_code", lsoa_name: "some updated lsoa_name", month: "some updated month", reported_by: "some updated reported_by"}
  @invalid_attrs %{context: nil, crime_id: nil, crime_type: nil, falls_within: nil, last_outcome_category: nil, latitude: nil, location: nil, longitude: nil, lsoa_code: nil, lsoa_name: nil, month: nil, reported_by: nil}

  def fixture(:crime) do
    {:ok, crime} = Reports.create_crime(@create_attrs)
    crime
  end

  describe "index" do
    test "lists all crimes", %{conn: conn} do
      conn = get conn, crime_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Crimes"
    end
  end

  describe "new crime" do
    test "renders form", %{conn: conn} do
      conn = get conn, crime_path(conn, :new)
      assert html_response(conn, 200) =~ "New Crime"
    end
  end

  describe "create crime" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, crime_path(conn, :create), crime: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == crime_path(conn, :show, id)

      conn = get conn, crime_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Crime"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, crime_path(conn, :create), crime: @invalid_attrs
      assert html_response(conn, 200) =~ "New Crime"
    end
  end

  describe "edit crime" do
    setup [:create_crime]

    test "renders form for editing chosen crime", %{conn: conn, crime: crime} do
      conn = get conn, crime_path(conn, :edit, crime)
      assert html_response(conn, 200) =~ "Edit Crime"
    end
  end

  describe "update crime" do
    setup [:create_crime]

    test "redirects when data is valid", %{conn: conn, crime: crime} do
      conn = put conn, crime_path(conn, :update, crime), crime: @update_attrs
      assert redirected_to(conn) == crime_path(conn, :show, crime)

      conn = get conn, crime_path(conn, :show, crime)
      assert html_response(conn, 200) =~ "some updated context"
    end

    test "renders errors when data is invalid", %{conn: conn, crime: crime} do
      conn = put conn, crime_path(conn, :update, crime), crime: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Crime"
    end
  end

  describe "delete crime" do
    setup [:create_crime]

    test "deletes chosen crime", %{conn: conn, crime: crime} do
      conn = delete conn, crime_path(conn, :delete, crime)
      assert redirected_to(conn) == crime_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, crime_path(conn, :show, crime)
      end
    end
  end

  describe "search crime" do
    setup [:create_crime]

    test "search returns correct crime", %{conn: conn, crime: crime} do
      conn = get conn, crime_path(conn, :search, %{"term" => "location"})
       assert html_response(conn, 200) =~ "some crime_id"
    end

    test "search returns nothing when no crimes found", %{conn: conn, crime: crime} do
      conn = get conn, crime_path(conn, :search, %{"term" => "xxx"})
       refute html_response(conn, 200) =~ "some crime_id"
    end
  end

  defp create_crime(_) do
    crime = fixture(:crime)
    {:ok, crime: crime}
  end
end
