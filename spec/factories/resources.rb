FactoryGirl.define do
  factory :resource do
    world_region_id { Faker::Number.between(1, 50)}
    title { Faker::Book.title }
    author { Faker::Book.author }
    news_source_id { Faker::Number.between(1, 50) }
    cognitive_bias_id { Faker::Number.between(1, 50) }
    resource_type_id { Faker::Number.between(1, 50) }
    t = Time.now
    date "#{t.year}-#{t.month}-#{t.day}"
    summary { Faker::Hacker.say_something_smart }
    academic_citation { Faker::Hacker.say_something_smart }
    abstract { Faker::Hacker.say_something_smart }
    url { Faker::Internet.url }

    admin_notes { Faker::Superhero.name }

    after(:build) do |resource|
        resource.attachments << FactoryGirl.build(:attachment, resource: resource)
    end


  end
end
