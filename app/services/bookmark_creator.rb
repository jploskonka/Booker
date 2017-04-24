class BookmarkCreator
  def initialize(attributes)
    @_attrs = attributes
  end

  def call
    new_bookmark = Bookmark.new(_attrs)
    new_bookmark.site = site

    new_bookmark
  end

  private

  attr_reader :_attrs

  def site
    Site.find_or_initialize_by(url: site_url)
  end

  def site_url
    _attrs["url"].split('/')[0..2].join('/')
  end
end
