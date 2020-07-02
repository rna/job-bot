class Job < ApplicationRecord
  validates_uniqueness_of :source_id
end
