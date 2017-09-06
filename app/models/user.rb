class User < ApplicationRecord
  has_paper_trail :ignore => [:created_at, :updated_at, :current_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :sign_in_count, :last_sign_in_at, :remember_created_at]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
