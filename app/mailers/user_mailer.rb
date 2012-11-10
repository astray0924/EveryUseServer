class UserMailer < ActionMailer::Base
  default :from => 'everyusekaist@gmail.com'
  default_url_options[:host] = "everyuse.org"
  def password_reset_email(user)
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)

    mail(
    :to => user.email,
    :subject => "Password Reset Instructions",
    :sent_on => Time.now)
  end
end
