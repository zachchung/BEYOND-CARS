# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/confirmation
  def confirmation
    booking = Booking.first
    BookingMailer.confirmation(booking)
  end

end
