class ProfilesController < ApplicationController
def new
  #@user = User.find(params[:user_id])
  #@profile = Profile.new(:user_id => @user.id)
  #@profile = @user.build_profile

      @user = User.find(params[:user_id])
      @profile = @user.build_profile
    

end
def create

    @user = User.find(params[:user_id])
      @profile = @user.build_profile(profile_params)
      if @profile.save
          flash[:notice] = 'Profile was successfully created.'
          redirect_to user_profile_path(:user_id =>params[:user_id], :id =>@profile.id) 
      else
        flash[:notice] = 'Error.  Something went wrong.'
          render :action => "new"
      end

  end

def index
  @profile=Profile.find_by_user_id(params[:user_id])
    if @profile
      redirect_to user_profile_path(:user_id =>params[:user_id], :id =>@profile.id)
    else
      #render action: 'new', :user_id => params[:user_id]
      redirect_to new_user_profile_path(:user_id =>params[:user_id])
    end
end

def edit
  @user = User.find(params[:user_id])
  @profile = @user.profile
end

def update
    @profile = Profile.find(params[:id])
      if @profile.update_attributes(profile_params)
        flash[:notice] = 'Profile was successfully updated.'
        redirect_to user_profile_path
      else
        render :action => "edit"
      end
  end

def show
    @profile=Profile.find(params[:id])
end

 def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
      redirect_to(profiles_url)
  end

    private 
      def profile_params
        params.require(:profile).permit(:avatar,:first_name, :last_name, :gender,:dob)

      end

end
