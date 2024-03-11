

# template_uuid_1 = "0b00e4e3-4d4e-4f47-ad04-4635e59d8fc2" ##Regular Day

# session_1 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{

#   date: ~D[2023-03-11],
#   session_number: 1,
#   group_name: "Group A",
#   chamber_from_time: ~T[08:50:00],
#   chamber_to_time: ~T[09:15:00],
#   reporting_from_time: ~T[08:15:00],
#   reporting_to_time: ~T[08:30:00],
#   seats: 50,
#   is_active: true,
#   template_id: template_uuid
# })



# # Session 2
# session_2 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 2,
#   group_name: "Group A",
#   chamber_from_time: ~T[09:20:00],
#   chamber_to_time: ~T[09:45:00],
#   reporting_from_time: ~T[08:15:00],
#   reporting_to_time: ~T[08:30:00],
#   seats: 50,
#   is_active: false,
#   template_id: template_uuid_1
# })

# # Session 3
# session_3 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 3,
#   group_name: "Group B",
#   chamber_from_time: ~T[09:50:00],
#   chamber_to_time: ~T[10:05:00],
#   reporting_from_time: ~T[08:30:00],
#   reporting_to_time: ~T[08:45:00],
#   seats: 50,
#   is_active: true,
#   template_id: template_uuid_1
# })

# # Session 4
# session_4 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 4,
#   group_name: "Group B",
#   chamber_from_time: ~T[10:10:00],
#   chamber_to_time: ~T[10:25:00],
#   reporting_from_time: ~T[08:30:00],
#   reporting_to_time: ~T[08:45:00],
#   seats: 50,
#   is_active: true,
#   template_id: template_uuid_1
# })

# # Session 5
# session_5 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 5,
#   group_name: "Group B",
#   chamber_from_time: ~T[10:30:00],
#   chamber_to_time: ~T[10:45:00],
#   reporting_from_time: ~T[08:30:00],
#   reporting_to_time: ~T[08:45:00],
#   seats: 50,
#   is_active: true,
#   template_id: template_uuid_1

# })

# # Session 6
# session_6 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 6,
#   group_name: "Group B",
#   chamber_from_time: ~T[10:50:00],
#   chamber_to_time: ~T[11:05:00],
#   reporting_from_time: ~T[08:30:00],
#   reporting_to_time: ~T[08:45:00],
#   seats: 50,
#   is_active: true,
#   template_id: template_uuid_1

# })

# # Session 7
# session_7 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 7,
#   group_name: "Group B",
#   chamber_from_time: ~T[11:10:00],
#   chamber_to_time: ~T[11:25:00],
#   reporting_from_time: ~T[08:30:00],
#   reporting_to_time: ~T[08:45:00],
#   seats: 50,
#   is_active: false,
#   template_id: template_uuid_1
# })




template_uuid_2 = "6f6146c8-701d-4339-897c-42d2b209632a" ##darshan Day

session_1 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
  date: ~D[2023-03-11],
  session_number: 1,
  group_name: "Group A",
  chamber_from_time: ~T[08:50:00],
  chamber_to_time: ~T[09:10:00],
  reporting_from_time: ~T[08:15:00],
  reporting_to_time: ~T[08:30:00],
  seats: 50,
  is_active: true,
  template_id: template_uuid_2
})

# session_2 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 2,
#   group_name: "Group A",
#   chamber_from_time: ~T[09:15:00],
#   chamber_to_time: ~T[09:30:00],
#   reporting_from_time: ~T[08:15:00],
#   reporting_to_time: ~T[08:30:00],
#   seats: 50,
#   is_active: true,
#   template_id: template_uuid_2
# })

# session_3 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 3,
#   group_name: "Group A",
#   chamber_from_time: ~T[09:35:00],
#   chamber_to_time: ~T[09:50:00],
#   reporting_from_time: ~T[08:15:00],
#   reporting_to_time: ~T[08:30:00],
#   seats: 50,
#   is_active: true,
#   template_id: template_uuid_2
# })

# session_4 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 4,
#   group_name: "Group A",
#   chamber_from_time: ~T[09:55:00],
#   chamber_to_time: ~T[10:10:00],
#   reporting_from_time: ~T[08:15:00],
#   reporting_to_time: ~T[08:30:00],
#   seats: 50,
#   is_active: false,
#   template_id: template_uuid_2
# })

# session_5 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 5,
#   group_name: "Group A",
#   chamber_from_time: ~T[10:15:00],
#   chamber_to_time: ~T[10:30:00],
#   reporting_from_time: ~T[08:15:00],
#   reporting_to_time: ~T[08:30:00],
#   seats: 50,
#   is_active: false,
#   template_id: template_uuid_2
# })

# session_6 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 6,
#   group_name: "Group A",
#   chamber_from_time: ~T[10:35:00],
#   chamber_to_time: ~T[10:50:00],
#   reporting_from_time: ~T[08:15:00],
#   reporting_to_time: ~T[08:30:00],
#   seats: 50,
#   is_active: false,
#   template_id: template_uuid_2
# })

# session_7 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 7,
#   group_name: "Group B",
#   chamber_from_time: ~T[10:55:00],
#   chamber_to_time: ~T[11:10:00],
#   reporting_from_time: ~T[08:30:00],
#   reporting_to_time: ~T[08:45:00],
#   seats: 50,
#   is_active: true,
#   template_id: template_uuid_2
# })

# session_8 = Mmbooking.Repo.insert!(%Mmbooking.Session.Session{
#   date: ~D[2023-03-11],
#   session_number: 8,
#   group_name: "Group B",
#   chamber_from_time: ~T[11:15:00],
#   chamber_to_time: ~T[11:30:00],
#   reporting_from_time: ~T[08:30:00],
#   reporting_to_time: ~T[08:45:00],
#   seats: 50,
#   is_active: true,
#   template_id: template_uuid_2
# })
