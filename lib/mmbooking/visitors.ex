defmodule Mmbooking.Visitors do


  import Ecto.Query, warn: false
  alias Mmbooking.Repo
  alias Mmbooking.Visitor.Visitor


  def change_personal_changeset(%Visitor{} = visitor, attrs \\ %{}) do
    Visitor.personal_changeset(visitor, attrs)
  end

  def change_booking_changeset(%Visitor{} = visitor, attrs \\ %{}) do
    Visitor.booking_changeset(visitor, attrs)
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

  def get_visitors_by_email(email) do
    Visitor
    |> where(email: ^email)
    |> Repo.all()
  end

  def get_visitor_by_id(id) do
    Repo.get!(Visitor, id)
  end

  def update_visitor_personal(%Visitor{} = visitor, attrs) do
    visitor
    |> Visitor.personal_changeset(attrs)
    |> Repo.update()
  end

  def update_visitor(%Visitor{} = visitor, attrs) do
    visitor
    |> Visitor.changeset(attrs)
    |> Repo.update()
  end


  def get_visitor_by_email(email) do
    Repo.get_by(Visitor, email: email)
  end

  def list_visitor do
    Repo.all(Visitor)
  end


  def search_visitors(params) do
    Visitor
    |> get_search_results(params)
    |> Repo.all()
  end


  def get_search_results(q, params) do
    IO.inspect(params, label: "paramsq")
    params
    |> Enum.reject(fn {_key, value} -> String.trim(value) == "" end)
    |> Enum.reduce(q, fn

      {"first_name", first_name}, q ->
        from p in q, where: ilike(p.first_name, ^"#{first_name}%")

      {"last_name", last_name}, q ->
        from p in q, where: ilike(p.last_name, ^"#{last_name}%")

      {"city", city}, q ->
        from p in q, where: ilike(p.city, ^"#{city}%")

      {"email", email}, q ->
        from p in q, where: ilike(p.email, ^"#{email}%")

      {"dob", dob}, q ->
        from p in q, where: p.dob == ^dob

      _, q -> q
      end)
  end


end
