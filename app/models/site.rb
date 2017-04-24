class Site < ApplicationRecord
  validates :url, presence: true, url: true

  has_many :bookmarks
end
