defmodule D2 do
  require Integer
  defp parse_input() do
    "data/02/input.txt"
    |> File.read!()
    |> String.split(",")

  end
  defp recur(a,b,acc)
    when a > b, do: acc

  defp recur(a,b, acc) do
    #IO.puts(a)
    str = to_string(a)
    acc = if (Integer.is_even(String.length(str))) do
            {p1,p2}  = String.split_at(str,div(String.length(str),2))

      if p1 == p2 do
        #IO.puts("Found #{a}")
        [a|acc]
      else
        acc
      end
    else
      acc
    end
    recur(a + 1,b,acc )
  end



  defp find2(a,b,acc)
  when a > b, do: acc

  defp find2(a,b, acc) do
    #IO.puts(a)
    str = to_string(a)
    found = findseq(str,String.length(str),1)

    acc = if(found==str) do
        #IO.puts("Found #{a}")
         [a | acc]
    else
      acc
    end

    find2(a + 1,b,acc )
  end

  defp findseq(_a,length,chunksize)
    when chunksize >= length  , do: nil

  defp findseq(a,length,chunksize) do
    chunk = Enum.chunk_every(String.graphemes(a),chunksize)
    if(length(Enum.dedup(chunk))==1) do
      a
    else findseq(a,length,chunksize + 1)

   end
  end


  def main() do
    data = parse_input()
    #IO.inspect(data)
    d = Enum.map(data, fn s  -> String.split(s,"-") end) |> Enum.map( fn [a,b] -> {String.to_integer(a), String.to_integer(b)} end)
    #IO.inspect(d)
    p1 = Enum.flat_map(d, fn {a,b} -> recur(a,b,[]) end)
    #IO.inspect(p1)
    sum_p1 = Enum.sum(p1)
    IO.puts("P1: #{sum_p1}")


    p2 = Enum.flat_map(d, fn {a,b} -> find2(a,b,[]) end)
    #IO.inspect(p2)

    sum_p2 = p2 |> Enum.sum()
    IO.puts("P2: #{sum_p2}")





  end
end
