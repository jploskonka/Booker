class BookmarkFilterer
  def initialize(query)
    @_query = query
  end

  def call
    boo = Bookmark.where('url ILIKE :search OR title ILIKE :search', search: "%#{_query}%")
    boo.any? ? boo : Bookmark.all
  end

  private

  attr_reader :_query
end
