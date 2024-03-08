defmodule Mmbooking.EmailNotifier do
  import Swoosh.Email


  def submission_mail(visitor) do
    email =
    new()
    |> from("mm@auroville.org.in")
    |> to(visitor.email)
    |> subject("Acknowledgement of Booking Submission")
    |> text_body("""

        <p>Dear #{visitor.first_name},</p>

        <p>We are writing to inform you that your request for booking has been successfully submitted. An email acknowledging your submission will be sent to your registered Email ID shortly.</p>

        <p>Please be advised that our team will process your booking request within the next 72 hours. Should you not receive an email confirmation within this timeframe, please don't hesitate to reach out to us at <a href="mailto:mmconcentration@auroville.org.in">mmconcentration@auroville.org.in</a> for assistance.</p>

        <p>Kindly note that the submission of a booking request does not guarantee a confirmed booking. Bookings are confirmed based on the availability of seats at the time of processing the requests.</p>

        <p>Thank you for choosing our services, and we look forward to assisting you further.</p>

        <p>Best regards,<br>

  """)
    Mmbooking.Mailer.deliver(email)
  end

  def custom_mail(subject, message, visitor) do
    email =
    new()
    |> from("mm@auroville.org.in")
    |> to(visitor.email)
    |> subject(subject)
    |> text_body("""

        <p>Dear #{visitor.first_name},</p>

        <p>#{message}</p>
        <p>Best regards,<br>

    """)
    Mmbooking.Mailer.deliver(email)
  end


end
