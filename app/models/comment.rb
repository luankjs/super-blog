class Comment < ApplicationRecord
  belongs_to :post

  validates :text, presence: true
  validates :author_name, presence: true
  validates :author_email, presence: true, format: { with: Devise.email_regexp } 
end
