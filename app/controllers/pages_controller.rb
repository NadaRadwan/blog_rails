#our PagesController class extends ApplicationController class 
class PagesController < ApplicationController

	#home is the name of the instance method
	def home
		#we need to send a response by calling the method 'render' which is defined in ApplicationController
		#render takes a view template & sends in back to the browser
		#its gonna look for a  view template named home (could be named anything), do some processing if needed & then send the template back
		render{"home"}
	end

	def about
		render {"about"}
	end

	def contact
		render {"contact"}
	end

end