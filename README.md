# Yacsv

Basic csv parser written to learn some Elixir.

Usage is simple:

    Yacsv.parse("Some, string")

To customize the separator:

    Yacsv.parse("Some-string", '-')

It supports quoted values:

    Yacsv.parse("OSI, Office of Strategic Influence, \"Hello, Helicopter!\", 2003")

To customize the quote character:

    Yacsv.parse("OSI, Office of Strategic Influence, 'Hello, Helicopter!', 2003", ',', '\'')

Tests can be run with `mix test`.
