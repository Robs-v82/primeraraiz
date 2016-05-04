class SessionsController < ApplicationController
	def new
		@zonas = [
			"Anzures",
			"Condesa",
			"Cuauhtémoc",
			"Del Valle",
			"Escandón",
			"Juárez",
			"Mixcoac",
			"Narvarte",
			"Polanco",
			"Roma",
			"San José Insurgentes",
			"San Miguel Chapultepec",
			"San Pedro de los Pinos",
			"San Rafael",
			"Santa Maria La Ribera",
		]
	end

	def slider
	end

end
