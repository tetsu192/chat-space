FactoryGirl.define do

  factory :message do
    text            'aaa'
    image           Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/image.jpg'))
    user_id         '1'
    group_id        '1'
  end

end
