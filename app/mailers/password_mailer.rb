class PasswordMailer < ActionMailer::Base
  default_url_options[:host] = "everyuse.org"
  
  def deliver_password_reset_instructions(user)
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    
    mail(
    :to => user.email,
    :subject => "Password Reset Instructions",
    :sent_on => Time.now) do |format|
      format.html {render 'password_reset_instructions.erb' }
    end
  end
end
