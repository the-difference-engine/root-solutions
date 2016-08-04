FactoryGirl.define do
  factory :attachment do
      resource :resource
      url File.open(File.join(Rails.root, '/spec/fixtures/files/image.png'))
  end
end