defmodule CsvPhxWeb.CrimeController do
  use CsvPhxWeb, :controller

  alias CsvPhx.Reports
  alias CsvPhx.Reports.Crime

  def index(conn, _params) do
    crimes = Reports.list_crimes()
    render(conn, "index.html", crimes: crimes)
  end

  def new(conn, _params) do
    changeset = Reports.change_crime(%Crime{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"crime" => crime_params}) do
    case Reports.create_crime(crime_params) do
      {:ok, crime} ->
        conn
        |> put_flash(:info, "Crime created successfully.")
        |> redirect(to: crime_path(conn, :show, crime))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    crime = Reports.get_crime!(id)
    render(conn, "show.html", crime: crime)
  end

  def edit(conn, %{"id" => id}) do
    crime = Reports.get_crime!(id)
    changeset = Reports.change_crime(crime)
    render(conn, "edit.html", crime: crime, changeset: changeset)
  end

  def update(conn, %{"id" => id, "crime" => crime_params}) do
    crime = Reports.get_crime!(id)

    case Reports.update_crime(crime, crime_params) do
      {:ok, crime} ->
        conn
        |> put_flash(:info, "Crime updated successfully.")
        |> redirect(to: crime_path(conn, :show, crime))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", crime: crime, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    crime = Reports.get_crime!(id)
    {:ok, _crime} = Reports.delete_crime(crime)

    conn
    |> put_flash(:info, "Crime deleted successfully.")
    |> redirect(to: crime_path(conn, :index))
  end

  def search(conn) do
    conn
  end
end
