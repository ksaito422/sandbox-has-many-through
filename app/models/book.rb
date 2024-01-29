class Book < ApplicationRecord
  has_many :authorships
  has_many :authors, through: :authorships

  validate :validate_author_exists?

  def validate_author_exists?
    binding.b
    # authorships
    authors
    p '中間テーブルを経由する呼べる => ', authorships.any? { |as| as.author(&:exists?) }
    p '中間テーブルを無視すると呼べない => ', authors.any?(&:exists?)
  end
end
