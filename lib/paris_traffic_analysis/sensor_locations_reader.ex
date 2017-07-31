defmodule ParisTrafficAnalysis.SensorLocationReader do

  @csv_file_path Path.join(:code.priv_dir(:paris_traffic_analysis), "referentiel-comptages-routiers.csv")

  def read_as_map do
    File.read(@csv_file_path)
     |> split_rows
     |> delete_first_row
     |> split_columns
     |> build_map
  end

  defp split_rows {:ok, content} do
    String.split(content, "\n")
  end

  defp delete_first_row lines do
    List.delete_at(lines, 0)
  end

  defp split_columns lines do
    Enum.map lines, &String.split(&1, ";")
  end

  defp build_map lines do
    Enum.map lines, &(to_map(&1))
  end

  defp to_map [a, b, c, d, e , f] do
    %{
      object_id: a,
      id_arc: b,
      id_arc_tra: c,
      shape_len: d,
      geo_shape: e,
      geo_point_2d: f
    }
  end

  defp to_map [""] do

  end

end
