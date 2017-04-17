class Bookmark < ApplicationRecord
  validates :url, :title, presence: true
end
