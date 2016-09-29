Rails.application.routes.draw do
    #string could be "" or ''
    #get request ; we are forwarding to the pages controller
    #home (we could name something else not necessarly same name as /home) is the name of the action or method in the pages controller
    
    get "/" => "pages#home" #setting default page to home
    root "pages#home" #another way to set the default page is to use the method root

    get "/home" => "pages#home"
    get "/about" => "pages#about"
    get "/contact" => "pages#contact"

    #BlogPosts RESTful Resource
    #get "/blog_posts" => "blog_posts#index"
    #get "/blog_posts/new" => "blog_posts#new"
    #to define a dynamic route, we use a variable with a :
    #any dynamic part of the route is put in the params hash that is accessible from the controller
    #NOTE: most generic routes are put at the bottom (dynamic routes)
    #get "/blog_posts/:id" => "blog_posts#show", as: :blog_post
    #post "/blog_posts" => "blog_posts#create"
    #get "/blog_posts/:id/edit" => "blog_posts#edit"
    #patch "/blog_posts/:id" => "blog_posts#update"
    #delete "/blog_posts/:id" => "blog_posts#destroy"

    #this line replaces all the above
    #BlogPosts RESTful Resource
    resources :blog_posts
    
end
