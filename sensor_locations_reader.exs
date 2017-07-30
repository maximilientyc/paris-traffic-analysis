defmodule SensorLocationReader do

  def read_as_map do
    File.read("referentiel-comptages-routiers.csv")
     |> split_rows
     |> delete_first_row
     |> split_columns
     |> build_map
  end

  defp split_rows {:ok, content} do
    String.split(content, "\n")
  end

  defp delete_first_row content do
    List.delete_at(content, 0)
  end

  defp split_columns(content) do
    content
      |> Enum.map &String.split(&1, ";")
  end

  defp build_map(line) do
    line
     |> Enum.map &(to_map(&1))
  end

  defp to_map([a, b, c, d, e , f]) do
    %{
      object_id: a,
      id_arc: b,
      id_arc_tra: c,
      shape_len: d,
      geo_shape: e,
      geo_point_2d: f
    }
  end

  defp to_map([""]) do

  end

end
