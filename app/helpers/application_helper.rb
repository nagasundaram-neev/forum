module ApplicationHelper
	def up(str)
  str.upcase;
end
 def signed_in?
    !current_user.nil?
  end

 def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
 end

def is_admin?(name)
	name.eql?("admin")
end
end
