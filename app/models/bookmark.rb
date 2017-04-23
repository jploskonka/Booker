class Bookmark < ApplicationRecord
  validates :url, :title, presence: true
  validates :url, url: true

  belongs_to :site
end
