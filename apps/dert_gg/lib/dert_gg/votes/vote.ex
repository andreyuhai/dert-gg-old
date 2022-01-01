defmodule DertGG.Votes.Vote do
  import Ecto.Changeset

  use Ecto.Schema

  schema "votes" do
    belongs_to :entry, DertGG.Entries.Entry
    belongs_to :account, DertGG.Accounts.Account

    timestamps(type: :utc_datetime)
  end

  def changeset(vote, %{account: account, entry: %DertGG.Entries.Entry{} = entry}) do
    vote
    |> change()
    |> put_assoc(:account, account)
    |> put_assoc(:entry, entry)
    |> assoc_constraint(:entry)
    |> unique_constraint([:entry_id, :account_id])
  end

  def changeset(vote, %{account: account, entry: _} = attrs) do
    vote
    |> cast(attrs, [])
    |> cast_assoc(:entry, with: &DertGG.Entries.change_entry/2)
    |> put_assoc(:account, account)
    |> foreign_key_constraint(:entry_id)
    |> unique_constraint([:entry_id, :account_id])
  end
end
