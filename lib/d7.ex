defmodule D7 do
  require Integer

  defp parse_input() do
    lines = "data/07/input.txt"
    |> File.read!()
    |> String.split("\n")

    lines |> Enum.map(fn line -> line |> String.graphemes() end )

  end

  defp emit_beams(state,[],count), do: {state,count}

  defp emit_beams(state,[{x,y}|queue],count) do
    dy = y+1
      if dy >= length(state)
      do
        emit_beams(state,queue,count)
      else

      row = state |> Enum.at(dy)

      element = row |> Enum.at(x)
      {new_state,new_beams,add} = cond do
        element=="." -> new_state = state |> List.replace_at(dy,row |> List.replace_at(x,"|"))
                        {new_state,[{x,dy}],0}
        element=="^" -> new_state = state |> List.replace_at(dy,row |> List.replace_at(x-1,"|") |> List.replace_at(x+1,"|"))
                        {new_state,[{x-1,dy},{x+1,dy}],1}
        true -> {state,[],0}
      end
      #new_state |> Enum.each(&IO.puts/1)
      emit_beams(new_state,new_beams++queue,count+add)
    end
    end

  defp solve_p1(data) do

    first_row =  data |> Enum.fetch!(0)
    start = first_row |> Enum.find_index(fn e -> e=="S"end)

    {_state,count} =  emit_beams(data,[{start,0}],0)
    count

  end


  def main() do
    data = parse_input()

    {time_p1, result_p1} = :timer.tc(fn -> solve_p1(data) end)
    IO.puts("P1: #{result_p1}")
    IO.puts("µs P1: #{time_p1}")

   # {time_p2, result_p2} = :timer.tc(fn -> solve_p2(data2) end)
   # IO.puts("P2: #{result_p2}")
   # IO.puts("µs P2: #{time_p2}")
  end
end
