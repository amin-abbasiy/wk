class History < ApplicationRecord
  #TODO build a sequence of versions for a given reflection
  belongs_to :user
end
