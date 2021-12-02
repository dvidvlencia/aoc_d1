defmodule AocD1P1 do
  @moduledoc """
  Documentation for `AocD1P1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AocD1P1.start()
      {:ok, <COUNT>}

  """
  def start do
    get_input()
    |> calculate_measurements()
    |> parse_result()
  end

  defp get_input() do
    File.read("/home/dvidwork/Documents/projects/aoc_d1_p1/lib/input_p1.txt")
    |> case do
      {:ok, content} -> String.split(content, "\n", trim: true) |> Enum.map(fn x -> String.to_integer(x) end)
      {:error, _} -> {:error, "No se pudo leer el archivo"}
    end
  end

  defp calculate_measurements(input) do
    Enum.reduce(input, %{previous: nil, count: 0}, fn current_input, %{previous: previous, count: count} ->
      check_previous_number(previous, current_input, count)
    end)
  end

  # to handle first iteration only update the previous field
  defp check_previous_number(nil, current_input, count) do
    %{previous: current_input, count: 0}
  end

  # to handle next iterations
  defp check_previous_number(previous, current_input, count) do
    if previous <= current_input do
      update_count = count + 1
      %{previous: current_input, count: update_count}
    else
      %{previous: current_input, count: count}
    end
  end

  defp parse_result(%{count: count}), do: {:ok, count}
  defp parse_result(_), do: {:error, "No se pudo procesar"}

end
