require 'rails_helper'

 RSpec.describe Api::V1::PostsController, type: :controller do
   let(:my_user) { create(:user) }
   let(:other_user) { create(:user) }
   let(:my_topic) { create(:topic) }
   let(:my_post) { create(:post, topic: my_topic, user: my_user) }
   let(:new_post) { create(:post, topic: my_topic, user: my_user) }

   context "guest user" do

     it "PUT update returns http unauthorized" do
       put :update, topic_id: my_topic.id, id: my_post.id, post: {title: "Post title", body: "Post body"}
       expect(response).to have_http_status(:unauthorized)
     end

     it "POST create returns http unauthorized" do
       post :create, topic_id: my_topic.id, id: my_post.id, post: {title: "Post title", body: "Post body"}
       expect(response).to have_http_status(:unauthorized)
     end

     it "DELETE destroy http unauthorized" do
       delete :destroy, topic_id: my_topic.id, id: my_post.id
       expect(response).to have_http_status(:unauthorized)
     end
   end

   context "user trying CRUD on posts not belonging to them" do
   before do
     controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(other_user.auth_token)
   end

     it "PUT update returns http forbidden" do
       put :update, topic_id: my_topic.id, id: my_post.id, post: {title: "Post Title", description: "Post Description"}
       expect(response).to have_http_status(:forbidden)
     end

     it "DELETE destroy returns http forbidden" do
       delete :destroy, topic_id: my_topic.id, id: my_post.id
       expect(response).to have_http_status(:forbidden)
     end
   end

   context "authenticated users doing CRUD on posts they own" do
     before :each do
       my_user
       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
       my_post
       new_post
     end

     describe "PUT update" do
        before :each  do
          put :update, topic_id: my_topic.id, id: my_post.id, post: { title: new_post.title, body: new_post.body }
        end

        it "returns http success" do
          expect(response).to have_http_status(:success)
        end

        it "returns json content type" do
          expect(response.content_type).to eq 'application/json'
        end

        it "updates a post with the correct attributes" do
          updated_post = Post.find(my_post.id)
          expect(response.body).to eq(updated_post.to_json)
        end
      end

#PUT    /api/v1/topics/:topic_id/posts/:id(.:format)    api/v1/posts#update

     describe "POST create" do
         before :each do
           post :create, topic_id: my_topic.id, post: {user_id: my_user.id, title: my_post.title, body: my_post.body}
         end

         it "returns http success" do
           expect(response).to have_http_status(:success)
         end

         it "returns json content type" do
           expect(response.content_type).to eq 'application/json'
         end

         it "creates a post with the correct attributes" do
           hashed_json = JSON.parse(response.body)
           expect(hashed_json["title"]).to eq(my_post.title)
           expect(hashed_json["body"]).to eq(my_post.body)
         end
       end

     describe "DELETE destroy" do
         before { delete :destroy, topic_id: my_topic.id, id: my_post.id }

         it "returns http success" do
           expect(response).to have_http_status(:success)
         end
         it "returns json content type" do
           expect(response.content_type).to eq 'application/json'
         end

         it "returns the correct json success message" do         
           expect(response.body).to eq({"message" => "Post destroyed","status" => 200}.to_json)
         end

         it "deletes my_post" do
           expect{ Post.find(my_post.id) }.to raise_exception(ActiveRecord::RecordNotFound)
         end
       end
   end
 end
