FactoryGirl.define do
  factory :resource do
    world_region { Faker::Address.country }
    title { Faker::Book.title }
    author { Faker::Book.author }
    news_source { Faker::University.name }
    t = Time.now
    date "#{t.year}-#{t.month}-#{t.day}"
    summary { Faker::Hacker.say_something_smart }
    url { Faker::Internet.url }
    notes { Faker::Superhero.name }

    after(:build) do |resource|
        resource.attachments << FactoryGirl.build(:attachment, resource: resource)
    end

  end
end
