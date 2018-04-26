defmodule CsvPhx.Helpers.Ecto do
  
  # Prevent LIKE injections...
  # Taken from https://github.com/rails/rails/blob/fe4b0eee05f59831e1468ed50f55fbad0ce11e1d/activerecord/lib/active_record/sanitization.rb#L112
  def sanitize_sql_like(term) do
    Regex.replace(~r/[\\%_]/, term, "", global: true)
  end
end

  
