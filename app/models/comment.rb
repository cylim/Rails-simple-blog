class Comment < ApplicationRecord
  belongs_to :post

  validates_presence_of :post, :body
end
