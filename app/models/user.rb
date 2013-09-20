class User < ActiveRecord::Base
  has_one :profile, :autosave => true , dependent: :destroy
  accepts_nested_attributes_for :profile
	
 #call Back methods
	after_save :clear_password
  EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  #validates :password, :confirmation => true 
  validates_length_of :password, :in => 6..20, :on => :create
  
  def self.authenticate(username_or_email="", login_password="")
    
    if  EMAIL_REGEX.match(username_or_email)    
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_username(username_or_email)
      
    end

    if user && User.find_by_password(login_password)
      return user
    else
      
      return false
    end
  end      

  def is_admin?(admin_name)
      admin_name.eql?("admin")
  end

  def clear_password
    self.password = nil
  end

  def match_password(login_password="")
    password == login_password
    end
  def method_missing name
    true
  end
  
scope :recent, lambda { { :conditions => ['created_at > ?', 5.minutes.ago] } }



end
