defmodule ParisTrafficAnalysis.SensorLocationReader do

  @csv_file_path Path.join(:code.priv_dir(:paris_traffic_analysis), "referentiel-comptages-routiers.csv")

  def read do
    read_as_map fn([a, b, c, d, e , f]) ->
      %{
        object_id: a,
        id_arc: b,
        id_arc_tra: c,
        shape_len: d,
        geo_point_2d: f
      }
    end
  end

  def read_as_map map_fn do
    File.stream!(@csv_file_path)
      |> Stream.map(&String.split(&1, ";"))
      |> Stream.map(&(map_fn.(&1)))
      |> Enum.to_list
  end
  
end
