require 'rails_helper'

RSpec.describe Commenter, type: :model do
  it {is_expected.to belong_to :commentable}
end
