class SponsoredPost < ActiveRecord::Base
  belongs_to :topic
# removed comments - assignment didn't specify adding them,
# has_many :comments, dependent: :destroy
end
