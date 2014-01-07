defmodule Yacsv do

  defrecord State, current_word: [], all_words: [], quoted: false

  def parse(string, separator // ',', kuote // '"') do
    [ separator_char ] = separator
    [ quote_char ] = kuote
    parse(string |> bitstring_to_list, separator_char, quote_char, State.new)
      |> strip_spaces
  end
  defp parse([], _separator, _quote_char, state) do
    state = add_current_word_to_all_words(state)
    state.all_words(state.all_words |> Enum.reverse)
  end
  defp parse([head | tail], separator, quote_char, state) do
    state = parse_char(head, separator, quote_char, state, state.quoted)
    parse(tail, separator, quote_char, state)
  end

  defp parse_char(char, _separator, quote_char, state, _quoted) when char == quote_char do
    state.quoted !state.quoted
  end
  defp parse_char(char, separator, _quote_char, state, false) when char == separator do
    add_current_word_to_all_words(state)
  end
  defp parse_char(char, _separator, _quote_char, state, _quoted) do
    state.current_word [ char | state.current_word ]
  end

  defp add_current_word_to_all_words(state) do
    state = state.current_word(state.current_word |> Enum.reverse)
    state = state.all_words [ state.current_word | state.all_words ]
    state.current_word []
  end

  defp strip_spaces(state) do
    Enum.map state.all_words, fn(charlist) ->
      list_to_bitstring(charlist) |> String.strip
    end
  end

end
