class PropertiesController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_property, except: [:new, :create]
	before_action :require_appointment, except: [:new, :create]
	before_action :require_correct_user, except: [:new, :create]

	def new
		@neighborhoods = Neighborhood.all.order(:name)
		@working_hours = []
		(8..20).each {|x| @working_hours << "#{x}:00"}
	end

	def create
		property_info = property_params
		property_info.store("user_id","#{session[:user_id]}")
		property_info.store("agent_id","1")
		new_property = Property.new(property_info)
		if new_property.valid?
			new_property.save
			session[:property_id] = Property.last[:id]
			render json: {property_id:"#{session[:property_id]}"} 
		else
			errors = new_property.errors.full_messages
			render json: {errors:errors} 
		end
	end

	def show
		@full_properties = current_user.properties
		@properties = current_user.properties.pluck(:id)
		@appointments = []
		@properties.each do |property|
			property_data = appointments_data = ActiveRecord::Base.connection.execute("SELECT appointments.id AS appointment_id, appointments.status AS status, appointments.date AS date, appointments.time AS time, properties.street AS street FROM appointments JOIN properties ON appointments.property_id = properties.id WHERE properties.id = #{property}")
			@appointments << property_data
		end
		@property = Property.find(session[:property_id])
		@appointment = Appointment.find_by_property_id(@property[:id])
		t = Time.now
		next_two_days = t + (60*60*48)
		unless @appointment.status == "confirmada"
			if @appointment.date < next_two_days
				@appointment.update(status:"pendiente")
			end
		end
		@agent = @property.agent
		@agent_comments = Comment.where("commentable_type='Agent' and commentable_id='#{@agent.id}'")
		agent_integer = @agent.rating.to_i
		@blank_stars = 5 - agent_integer
		@stars = agent_integer
		add_arr = ["metroscubicos","segundamano","inmuebles-24","lamudi"]
		@adds = []
		add_arr.each do |x|
			add = Add.find_by_website(x) 
			if add.nil?
				@adds << {status: "inactive", file:x+".png"}
			else
				@adds << {status: "active", file:x+"_active.png", url:add.url}
			end
		end
		@working_hours = []
		(8..20).each {|x| @working_hours << "#{x}:00"}
		@dummy_appointment = Appointment.new
	end

	def change
		session[:property_id] = params[:id]
		redirect_to "/properties/#{session[:property_id]}"
	end

	def destroy
		Property.destroy(params[:id]) 
		if current_user.properties.any?
			session[:property_id] = User.find(session[:user_id]).properties.last.id
			redirect_to "/properties/#{session[:property_id]}"
		else
			current_user.destroy
			redirect_to "/users/logout"
		end
	end

	private

		def property_params
			params.require(:property).permit(:street, :number, :unit, :neighborhood_id, :owned_by)
		end
end
