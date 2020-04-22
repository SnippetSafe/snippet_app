class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :snippets
  has_many :comments
  has_many :likes
  has_many :languages, through: :snippets
end
