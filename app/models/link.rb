class Link < ApplicationRecord
  belongs_to :user, optional: true # Prevent AR::RecordInvalid

  has_many :votes
end
