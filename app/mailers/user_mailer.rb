class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Reset Password"
  end

  def alert_user(user, price_alert)
    @user = user
    @price_alert = price_alert
    mail to: user.email, subject: "Price Drop On Your #{@price_alert.event.name} Tickets!"
  end
end
