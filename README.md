 README
=========
#### Models: 
`User`, `Profile`

#### Controllers:
`User`, `Profile`, `Static_pages`, `Welcome_Mailer`

#### Views:
`Login`,`sign up`, `new`, `index`, `show`, `edit`, `about`,`contact us`, `etc`

## RoR concepts 


##### Nested routes   [routes.rb](config/routes.rb)

 	resources :users do 
     		collection do
       		post 'login'
       		get 'logout'
     		end
       		resources :profiles do
       		end
   	end

 
##### Scope [user.rb](app/models/user.rb)
 
 `scope :recent, lambda { { :conditions => ['created_at > ?', 5.minutes.ago] } }`

##### Helpers   [application_helper.rb](app/helpers/application_helper.rb) [profile_helper.rb](app/helpers/profile_helper.rb)

	def signed_in?
    		!current_user.nil?
  	end

 	def current_user
     		@current_user ||= User.find(session[:user_id]) if session[:user_id]
 	end
 
	 def age(dob)
  		now = Time.now.utc.to_date
  		now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	 end

	def gen(str)
 		if str.eql?('m') || str.eql?('M')
 			"Male"
 		else
 			"Female"
 		end
 	end

	def fullname(str1,str2)
		"#{str1} #{str2}"
	end


##### Layouts 

[_header.html.erb](app/views/layouts/_header.html.erb)

[_footer.html.erb](app/views/layouts/_footer.html.erb)

##### Image uploader
`include Paperclip::Glue`

##### Callbacks 

	after_update :update_user_info

	def update_user_info
		user.update_column(:updated_at, Time.now)
	end




