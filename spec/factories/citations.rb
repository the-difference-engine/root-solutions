FactoryGirl.define do
  factory :citation do
    resource_id 1
    citation_1 "MyText"
    citation_2 "MyText"
    title "MyString"
    author "MyString"
    news_source_id 1
    date "MyString"
    url "MyString"
  end
end
