defmodule Mmbooking.Session do
  import Ecto.Query, warn: false

alias Mmbooking.Repo
alias Mmbooking.Template.Template
alias Mmbooking.Session.Session


def get_sesssions_tmp_id(template_id) do
  Session
  |> where(template_id: ^template_id)
  |> Repo.all()
end



end
