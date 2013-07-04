class Procedure < ActiveRecord::Base
	has_many :hospitals_procedures
	has_many :hospitals, :through => :hospitals_procedures

end