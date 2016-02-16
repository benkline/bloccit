class Comment < ActiveRecord::Base
  belongs_to :post
# removed comments from sponsored posts as the assingment didn't specify connecting them and I couldn't figure out how to add this column to the db
# belongs_to :sponsored_post
end
