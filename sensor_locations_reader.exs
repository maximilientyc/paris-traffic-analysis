defmodule SensorLocationReader do

  def process_file do
    File.read("referentiel-comptages-routiers.csv")
     |> split_rows
     |> delete_first_row
     |> Enum.map(&String.split(&1, ";"))
     |> Enum.map(&(to_map(&1)))
  end

  def split_rows {:ok, content} do
    String.split(content, "\n")
  end

  def delete_first_row content do
    List.delete_at(content, 0)
  end

  def to_map([a, b, c, d, e , f]) do
    %{
      object_id: a,
      id_arc: b,
      id_arc_tra: c,
      shape_len: d,
      geo_shape: e,
      geo_point_2d: f
    }
  end

  def to_map([""]) do

  end

end
