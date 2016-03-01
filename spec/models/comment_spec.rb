require 'rails_helper'
require 'random_data'

RSpec.describe Comment, type: :model do

  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:comment) { Comment.create!(body: 'Comment Body', user: user) }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }

  it {is_expected.to have_many :commenters}
  it {is_expected.to have_many(:topics).through(:commenters) }
  it {is_expected.to have_many(:posts).through(:commenters) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "responds to body" do
      expect(comment).to respond_to(:body)
    end
  end

end
