class UserMailer < ActionMailer::Base
  default from: "roberto.valladarespiedras@gmail.com"


	def greeting
		current_time = Time.now.to_i
		midnight = Time.now.beginning_of_day.to_i
		noon = Time.now.middle_of_day.to_i
		five_pm = Time.now.change(:hour => 17 ).to_i
		eight_pm = Time.now.change(:hour => 20 ).to_i
		if midnight.upto(noon).include?(current_time)
			@greeting = "Buenos días"
		elsif noon.upto(eight_pm).include?(current_time)
			@greeting = "Buenas tardes"
		elsif eight_pm.upto(midnight + 1.day).include?(current_time)
			@greeting = "Buenas noches"
		end	
	end

	def welcome_email(user)
		@user = user
		@greeting = greeting
		mail(to: @user.email, subject: 'Tu cita ha quedado agendada')
	end
end
