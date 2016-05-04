class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	helper_method :current_user, :greeting

	def current_user
		@user = User.find(session[:user_id])
	end

	def require_login
		if session[:user_id] == nil
			redirect_to '/users/logout'
		end
	end

	def require_property
		if User.find(session[:user_id]).properties.length < 1
			redirect_to '/properties/new'
		end 
	end

	def require_appointment
		if User.find(session[:user_id]).properties.last.appointments.length < 1
			redirect_to '/properties/new'
		end
	end

	def require_correct_user
		if Property.find(session[:property_id]).user.id != session[:user_id]
			redirect_to '/users/logout'
		end
	end

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

	def confirm
		current_time = Time.now.to_i
		midnight = Time.now.beginning_of_day.to_i
	end

end
