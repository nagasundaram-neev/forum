class Profile < ActiveRecord::Base
	belongs_to :user 
	after_update :update_user_info
	include Paperclip::Glue
  #attr_accessible :avatar
  has_attached_file :avatar
	
	def update_user_info
		user.update_column(:updated_at, Time.now)
	end
end
