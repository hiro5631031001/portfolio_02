class Book < ApplicationRecord

  belongs_to :user
  has_many :comments

  validates :title,      presence: true
  validates :author,     presence: true
  validates :publisher,  presence: true
  validates :isbn,       presence: true
  validates :image,      presence: true
  validates :url,        presence: true

end
