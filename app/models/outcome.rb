class Outcome < ActiveRecord::Base
	belongs_to :hospital, :foreign_key => 'provider_id'
end
