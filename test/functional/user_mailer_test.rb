require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def test_password_reset_email
    user = User.find(1)

    # Send the email, then test that it got queued
    email = UserMailer.password_reset_email(user).deliver
    assert !ActionMailer::Base.deliveries.empty?
  end
end
