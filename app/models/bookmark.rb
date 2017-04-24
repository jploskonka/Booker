class Bookmark < ApplicationRecord
  validates :url, :title, presence: true
  validates :url, url: true

  belongs_to :site

  before_validation :handle_site_grouping

  private

  def handle_site_grouping
    return unless url.present?

    self.site = SiteManager.new(self).call
  end
end
