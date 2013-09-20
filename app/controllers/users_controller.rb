class UsersController < ApplicationController
 def index
    @users = User.all
    @recent=User.recent
  end

  
  def new
    @user = User.new
  end
   
  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:notice]= "You Signed up successfully"
      session[:user_id]=@user.id
      WelcomeMailer.welcome_email(@user).deliver
  		redirect_to new_user_profile_path(:user_id =>@user)
  	else
  		render action: 'new'
  	end   
  end

def login
      authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    if  authorized_user
      flash[:notice]= ""  
      admin_name="#{authorized_user.username}"
      session[:user_id] = authorized_user.id
      flash[:notice]="Wow Welcome again, you logged in as #{authorized_user.username}"
      if admin_name.eql?("admin")
         redirect_to users_path
      else
        redirect_to user_path(:id => authorized_user.id )
      end
    else
    #flash.now[:notice] ="invalid"
    render "login"  
    end
end

def logout
  session[:user_id] = nil
  flash[:notice]="Logged Out"
  redirect_to root_path
end

def show
  if session[:user_id] == nil
    redirect_to "/"
  else
  @user = User.find(params[:id])
  end
end

  def destroy
   @user = User.find(params[:id])
    if @user.present?
      @user.destroy
    end
    redirect_to users_path
  end
	
  def set_user
      @user = User.find(params[:id])
    end


  private

  	def user_params
      params.require(:user).permit(:username,:email,:password)
    end
end
