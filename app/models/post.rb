class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    validates :category, inclusion: {in: ['Fiction', 'Non-Fiction']}
    validate :clickbait?

    # CLICKBAIT_STRINGS = ["Won't Believe", "Secret", "Top [number]", "Guess"]

    CLICKBAIT_PATTERNS = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
      ]

    def clickbait?
        if CLICKBAIT_PATTERNS.none? {|string| string.match title}
            errors.add(:title, "this is clickbait")
        end
    end
end
