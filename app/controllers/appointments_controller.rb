class AppointmentsController < ApplicationController
  
	def create
		appointment_info = appointment_params
		appointment_info.store("property_id", session[:property_id])
		new_appointment = Appointment.new(appointment_info)
		if new_appointment.valid?
			new_appointment.save
			UserMailer.welcome_email(current_user).deliver
			session[:appointment_id] = Appointment.last[:id]
			render json: {property_id:"#{session[:property_id]}"} 
		else
			errors = new_appointment.errors.full_messages
			render json: {errors:errors} 
		end
	end

	def confirm
		appointment = Appointment.find(confirm_params[:id])
		appointment.update_attribute(:status,"confirmada")
		redirect_to "/properties/#{session[:property_id]}"
	end

  	private
	  	def appointment_params
	  		params.require(:appointment).permit(:date, :time, :contact)
	  	end

	  	def confirm_params
	  		params.require(:appointment).permit(:id)
	  	end
end
