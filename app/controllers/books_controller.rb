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

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to root_path
    else
      render :new
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
    params.permit(:title,
                  :author,
                  :isbn,
                  :publisher,
                  :image,
                  :url)
  end

end
