class Subtag < ApplicationRecord
  has_many :resources, through: :resources_subtags
  has_many :resources

  belongs_to :tag
end
