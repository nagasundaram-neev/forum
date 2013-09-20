module ProfilesHelper
	
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

end
