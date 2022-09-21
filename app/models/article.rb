class Article < ApplicationRecord
  belongs_to :category
  has_many :comments
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :body, presence: true
end
