class UserBook < ApplicationRecord
  belongs_to :book
  belongs_to :user
  #attr_accessor :rating, :book_id, :user_id
end
