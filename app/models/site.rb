class Site < ApplicationRecord
  validates :url, presence: true, url: true
end
