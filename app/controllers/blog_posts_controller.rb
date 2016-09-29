class BlogPostsController < ApplicationController
	
	def index

		#BlogPost.all gets all blog posts from the db
		#putting @ before the variable name makes it an instance variable which can be accessed from the view
		@blog_posts_array = BlogPost.all

		#remember that we always have to render or give a response to adhere to HTTP protocol
		#in places where the view we render has the same name as the action, we dont need to explicitly
		#write render RAILS DOES IT FOR US
		#this is called IMPLICIT VIEWS
		##render("index")
	end

	def show
		#we are trying to get the dynamic part of the url from the params hash
		@blog_post_var=BlogPost.find params[:id]
		##render ("show")
	end

	def new
		#we will create a dummy blog post to help us build the form
		#we will not save this blog post
		@blog_post=BlogPost.new
		##render ("new")
	end

	def create
		#to generate a POST request, we can use the form-for as we did in the new.html.erb and in the html that is gerenated, 
		#there is an action attribute that specifies the url we are sending the form to
		#any time you create a form, we can submit a request to a certain url
		#to send payload with the form, any input data you submit with the form will go as data (text area and text field)
		
		#in ruby, we have he default constructor which is just .new and 
		#we also have another one which takes in a hash
		
		#when we sumit the new form, a post request comes in, the payload data contains blog_post[title] and blog_post[body] (i got this 
		#from looking at he source code for new.html.erb)
		#rails then takes that data and puts it in a hash inside the params hash which contained the dynamic parameters (like id from SHOW)
		#rails relies on the fact that the naming of the dummy variable in new matches that of the instance variable we are creating in create
		#so, if i do params[:blog_post] this gives me the hash that contains the values entered in the form
		
		#this is dangerous because you are using (new) which is mass assigning attributes (possible to have poeple enter isAdmin)
		#therefore, we need to whiteList (specify what you allow in and what you dont) what can go in to new
		#this is called STRONG PARAMETERS
		#@blog_post=BlogPost.new(params[:blog_post])
		#threfore we do:

		#SAFER
		#if a blog_post doesnt come in as part of your params, this is gonna fail
		#within the blog_post hash, & if there is a blog_post, we only permit the attributes title and body

		#blog_post_sanitized_params is a private method at the bottom
		@blog_post=BlogPost.new(blog_post_sanitized_params)
		
		#save returs boolean specifyinh if save was successful
		if(@blog_post.save)
			#redirect_to is an instruction to go to another request (instance varaibles are not shared)
			#this is different from a render which is not another request. Render is within the same request cycle
			redirect_to "/blog_posts/" + @blog_post.id.to_s #to_s is toString

		else
			render ("new")
		end
	end

	def edit
		#remember that params is a hash encapsulates any part of the dynamic route
		id = params[:id]
		@blog_post = BlogPost.find(id)
		##render ("edit")
	end

	def update
		blog_post = BlogPost.find(params[:id])
		
		#blog_post_sanitized_params is a private methos at the bottom
		#.updates updates the object in memory and calls .save to the db as well and return T/F depending on if it is successful
		if blog_post.update(blog_post_sanitized_params)
			redirect_to "/blog_posts/#{blog_post.id}" 
			#anything inside #{} is ruby code
			#this is called string interpolation
			#this is equal to redirect_to "/blog_posts" + @blog_post.id.to_s		
		else
			#since the edit form requires access to the blog_post
			@blog_post=blog_post
			render("edit")
		end
	end

	def destroy
		blog_post = BlogPost.find(params[:id])
		blog_post.destroy
		redirect_to "/blog_posts"
	end

	#anything beneath the key word private is private
	private 

		#now in the create and update method, we dont need ti define blog_post_sanitized_params 
		def blog_post_sanitized_params
			params.require(:blog_post).permit(:title, :body)
		end

end



