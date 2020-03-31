class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  # validates :title, presence: true
  # validates :body, presence: true
  attachment :profile_image
  validates :introduction, length: {maximum: 50}
  validates :name, presence: true, length: {in: 2..20}

end