class Client < ActiveRecord::Base 
belongs_to :employee

validates :name ,presence:true, uniqueness:true
validates :industry, presence: true 
validates :priority, presence: true 


end