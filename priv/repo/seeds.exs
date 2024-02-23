# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mmbooking.Repo.insert!(%Mmbooking.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.



Mmbooking.Repo.insert!(%Mmbooking.Visitor.Visitor{

  visited: "no",
  email: "kodi@gmail.com",
  first_name: "kodi",
  last_name: "bank",
  dob: ~D[2024-02-17],
  country: "india",
  city: "tamilbadu",
  preferred_date: ~D[2024-02-17],
  alternate_date: ~D[2024-02-17],
  arrival_date: ~D[2024-02-17],
  departure_date: ~D[2024-02-17],
  note: "ddsuygfugf",
  stay: "hrjhij"

})
