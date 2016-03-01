class Comment < ActiveRecord::Base
  has_many :commenters
  has_many :posts, through: :commenters, source: :commentable, source_type: :Post
  has_many :topics, through: :commenters, source: :commentable, source_type: :Topic
  belongs_to :user

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
end
