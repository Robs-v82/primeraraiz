class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create, :login, :logout]
	before_action :require_property, except: [:new, :create, :login, :logout]
	before_action :require_appointment, except: [:new, :create, :login, :logout]

	def new
	end

	def create
		puts user_params
		user_info = user_params
		phone_option = user_info.delete(:phone_option)
		phone_number = user_info.delete(:phone_number)
		if phone_option == "mobile"
			user_info.store("mobile_phone",phone_number)
		else
			user_info.store("other_phone",phone_number)
		end
		new_user = User.new(user_info)
		respond_to do |format|
			if new_user.valid?
				new_user.save
				session[:user_id] = User.last[:id]
				format.json { render json: {user_id:"#{session[:user_id]}"} }
			else
				errors = new_user.errors.full_messages
				format.json { render json: {errors:errors} }
			end
		end
	end

	def login
		login_user = User.find_by_email(login_params[:email])
		respond_to do |format|
			if login_user
				if login_user.authenticate(login_params[:password])
					session[:user_id] = login_user[:id]
					if login_user.properties.any?
						session[:property_id] = User.find(session[:user_id]).properties.last.id
						format.json { render json: {property_id:"#{session[:property_id]}"} }
					else
						format.json { render json: {user_id:"#{session[:user_id]}"} }
					end
				else
					format.json { render json: {error_message:"La contraseña proporcionada no es válida"} }
				end
			else
				format.json { render json: {error_message:"Correo no registrado"} }
			end
		end		
	end

	def logout
		session[:user_id] = nil
		session[:property_id] = nil
		current_user = nil
		redirect_to "/sessions/new"
	end

	private

		def user_params
			params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation, :phone_number, :phone_option)			
		end

		def login_params
			params.require(:user).permit(:email, :password)
		end

end


