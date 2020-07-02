class BooksController < ApplicationController
  def index
  end

  def new

    @books = []

    @keyword = params[:keyword]

    if @keyword.present?
      apibooks = RakutenWebService::Books::Book.search({title: @keyword, hit: 15})

      apibooks.each do |apibook|
        book = Book.new(change(apibook))
        @books << book
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
    url = apibook['itemUrl']

    {
      title: title,
      author: author,
      isbn: isbn,
      publisher: publisher,
      image: image,
      url: url
    }
  end

  def book_params
    params.require(:book).permit(:title,
                                 :author,
                                 :isbn,
                                 :publisher,
                                 :image,
                                 :url)
  end

end
