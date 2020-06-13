class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cars
  has_many :bookings

  validates :first_name, :last_name, presence: true

  after_create :send_welcome_email

  def fullname
    name = "#{first_name} #{last_name}"
    name.strip
  end

  def pending_requests
    Booking.joins(:car).where(cars: { user: self }).where(status: Booking::BOOKING_STATUS[:pending])
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
