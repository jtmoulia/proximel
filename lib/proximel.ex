defmodule Proximel do
  @moduledoc """
  Distel + Elixir integration.
  """


  @doc """
  Expand the expression to a list of possible completions.
  """
  @spec expand(String.t | [integer]) :: [[integer]]
  def expand(expr) when is_binary(expr) do
    expr |> String.to_char_list |> expand
  end
  def expand(expr) when is_list(expr) do
    expr |> Enum.reverse |> expand([])
  end

  @doc false
  defp expand(expr, acc) do
    case IEx.Autocomplete.expand(expr) do
      {:yes, hint, []}  -> (Enum.reverse(hint) ++ expr) |> expand(acc)
      {:yes, [], exprs} -> exprs
      {:no, [], []}     -> acc
    end
  end

end
