defmodule MmbookingWeb.VisitorController do
  use MmbookingWeb, :controller


  def create(conn, %{"visitor_email" => visitor_email}) do
    conn
    |> put_session(:visitor_email, visitor_email)
    |> redirect(to: "/mmaccess/new_visit")
  end



  def exist(conn, %{"visitor_email" => visitor_email}) do
    conn
    |> put_session(:visitor_email, visitor_email)
    |> redirect(to: "/mmaccess/visitor_page")
  end


end
