class Employee < ActiveRecord::Base 
has_many :clients
has_secure_password

validates :name, uniqueness: true, presence:true 
validates :password, presence: true
validates :title, presence: true
validates :division, presence: true




end