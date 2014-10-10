class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum status: %i(common admin)

  rails_admin do
  	# Change visibility
  	# https://github.com/sferik/rails_admin/wiki/Navigation
  	#
    # visible false
  end
end
