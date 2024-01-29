module Api
  class BooksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      book = Book.new(title: book_params[:title])
      author = Author.first

      book.authorships.build(author: author)
      # book.authors << author

      if book.save
        render json: book, status: :created
      else
        render json: book.errors, status: :unprocessable_entity
      end
    end

    def update
      book = Book.find(params[:id])

      book_params[:authors].each do |author_params|
        # 既存のAuthorを検索または新しいAuthorを作成
        author = Author.find_or_create_by(name: author_params[:name])
        # 中間テーブルを介してBookとAuthorを関連付け
        book.authors << author
      end

      if book.update(book_params)
        render json: book
      else
        render json: book.errors, status: :unprocessable_entity
      end
    end

    private

    def book_params
      params.require(:book).permit(:title)
    end
  end
end
