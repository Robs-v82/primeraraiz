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

	def update
		appointment_id = (params[:id])
		if Appointment.update(appointment_id, date:update_params[:date], time:update_params[:time]).valid?
			newdate = Appointment.find(params[:id]).date
			render json: {appointment_date:"#{newdate}"}
		else
			errors = Appointment.update(appointment_id, date:update_params[:date], time:update_params[:time]).errors.full_messages
			render json: {errors:errors}
		end

	end

	def generate_pdf (pdf) 
		html = render_to_string_with_wicked_pdf(
			:pdf => pdf,
			:template => pdf,
			:layout => 'pdf.html.erb',
			:encoding => 'UTF-8',
			:page_size        => 'A4',
			:dpi              => '300',
			:print_media_type => true,
			:no_background    => true,
			:margin => {
			  :top => 50,
			  :bottom => 25
			},
		)
	end

  	private
	  	def appointment_params
	  		params.require(:appointment).permit(:date, :time, :contact)
	  	end

	  	def confirm_params
	  		params.require(:appointment).permit(:id)
	  	end

	  	def update_params
	  		params.require(:appointment).pemit(:date, :time)
	  	end
end
