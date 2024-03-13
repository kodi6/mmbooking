defmodule Mmbooking.Templates do
  import Ecto.Query, warn: false


  alias Mmbooking.Repo
  alias Mmbooking.Template.Template
  alias Mmbooking.Session.Session


  def list_templates do
    Enum.map(Repo.all(Template), fn template -> template.name end)
  end


  def create_template(attrs \\ %{}) do
    %Template{}
    |> Template.changeset(attrs)
    |> Repo.insert!()
  end

def get_template(id) do
  Repo.get(Template, id)
end


def get_template_by_name(name) do
  Repo.get_by(Template, name: name)
end

end
