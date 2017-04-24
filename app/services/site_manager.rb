class SiteManager
  def initialize(bookmark)
    @_bookmark = bookmark
  end

  def call
    Site.find_or_initialize_by(url: site_url)
  end

  private

  attr_reader :_bookmark

  def site_url
    _bookmark.url.split('/')[0..2].join('/')
  end
end
