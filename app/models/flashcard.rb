class Flashcard < ApplicationRecord
  enum status: { not_remember: 0, repeat: 1, remember: 2 }

  belongs_to :user
end
