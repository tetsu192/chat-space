FactoryGirl.define do

  factory :message do
    id  Faker::Number.number(5)
    text  Faker::Lorem.word
    image  Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/image.jpg'))
    user_id  Faker::Number.number(5)
    group_id  Faker::Number.number(5)
  end

end
