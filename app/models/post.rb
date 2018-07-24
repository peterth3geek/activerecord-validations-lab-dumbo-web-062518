class TitleValidator < ActiveModel::Validator
  def validate(record)
    validity = []
    if record.title == nil
      record.errors[:title] << "Musth have title"
    else
      validity = record.title.split.select {|word| clickbait.include?(word) == true}
    end
    if validity.empty?
      record.errors[:title] << "must be clickbait"
    end
  end

  def clickbait
    ["Won't", "Believe", "Top", "Guess", "Secret"]
  end
end



class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: {minimum: 250}
  validates :summary, length:{maximum: 250}
  validates :category, inclusion: {in: %w(Fiction Nonfiction), messasge: "%{value} needs to be either Fiction or NonFiction"}
  include ActiveModel::Validations
  validates_with TitleValidator
end
