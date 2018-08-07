class Book < ApplicationRecord
  has_many :user_books
  accepts_nested_attributes_for :user_books, allow_destroy: true
  has_many :users, through: :user_books
  accepts_nested_attributes_for :users,  allow_destroy: true
  has_attachment :photo
  validates :title, :author, presence: true
  has_many :comments
  accepts_nested_attributes_for :users
end
