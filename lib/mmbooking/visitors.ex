defmodule Mmbooking.Visitors do


  import Ecto.Query, warn: false
  alias Mmbooking.Repo
  alias Mmbooking.Visitor.Visitor


  def change_step1_changeset(%Visitor{} = visitor, attrs \\ %{}) do
    Visitor.step1_changeset(visitor, attrs)
  end

  def change_step2_changeset(%Visitor{} = visitor, attrs \\ %{}) do
    Visitor.step2_changeset(visitor, attrs)
  end


  def change_visitor(%Visitor{} = visitor, attrs \\ %{}) do
    Visitor.changeset(visitor, attrs)
  end

  def create_visitor(attrs \\ %{}) do
    %Visitor{}
    |> Visitor.changeset(attrs)
    |> Repo.insert()
  end


  def list_email do
    Enum.map(Repo.all(Visitor), fn visitor -> visitor.email end)
  end
end
