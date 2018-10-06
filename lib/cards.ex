defmodule Cards do

  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """
  @doc """
  Returns a list of strings represanting a deck of cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    for suit <- suits, value <- values do
        "#{value} of #{suit}"
    end
  end

  @doc """
  Shuffles the deck and arranges cards in random order
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains the given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, hand) do
     Enum.member?(deck, hand)
  end

  @doc """
  Divides the into two elements based on `hand_size` argument

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Saves the deck into a binary file based on `filename` argument
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Loads the binary file based on `filename` argument and throws an error when file does not exist
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _ } -> "That file does not exist!"
    end
  end

  @doc """
  Creates a hand of a given size based on `hand_size` argument
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
