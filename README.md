# PhstPhenetic

**A Library for Classifying Elixir Data Structures**

## Documentation

The `PhStPhenetic` module is a library for grouping Elixir data structures into
similar groups. It creates functions that given a single example of a data
structure will allow the programmer to determine whether any other data
structures are similar.

Phenetics is the biological science of classifying organisms based on their
structure w/o reference to their evolutionary history. This library works in
a similar manner in that it examines a single member of the group and creates
a function that will determine whether any other data structure is similar.






## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add phst_phenetic to your list of dependencies in `mix.exs`:

        def deps do
          [{:phst_phenetic, "~> 0.0.1"}]
        end

  2. Ensure phst_phenetic is started before your application:

        def application do
          [applications: [:phst_phenetic]]
        end

