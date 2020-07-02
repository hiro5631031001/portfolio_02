class BooksController < ApplicationController
  def index
  end

  def new
    @books = []

    @keyword = params[:keyword]
    if @keyword.present?
      apibooks = RakutenWebService::Books::Book.search({title: @keyword, hit: 15})

      binding.pry

      apibooks.each do |apibook|
        book = Book.new(change(apibook))
        @books = book
      end
    end
  end

  private 

  def change(apibook)
    title = apibook['title']
    author = apibook['author']
    publisher = apibook['publisherName']
    isbn = apibook['isbn']
    image = apibook['mediumImageUrl']

    {
      title: title,
      isbn: isbn,
      publisher: publisher,
      image: image 
    }
  end

end
