class BooksController < ApplicationController

  def index
    @books = Book.all
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

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to root_path
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
                  :url).merge(user_id: current_user.id)
  end

end
