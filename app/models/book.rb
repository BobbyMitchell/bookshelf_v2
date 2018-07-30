class Book < ApplicationRecord
  has_many :user_books
  accepts_nested_attributes_for :user_books, allow_destroy: true
  has_many :users, through: :user_books
  has_attachment :photo


  validates :title, :author, presence: true
  validates :rating, inclusion: {in: [1,2,3,4,5], allow_nill: false }
end
