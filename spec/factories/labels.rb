require 'random_data'

 FactoryGirl.define do
   factory :label do
     sequence(:name){|n| RandomData.random_word }
   end
 end
