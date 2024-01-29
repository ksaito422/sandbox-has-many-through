class Author < ApplicationRecord
  has_many :authorships
  has_many :books, through: :authorships

  def exists?
    true
  end
end
