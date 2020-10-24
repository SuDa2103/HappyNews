class Link < ApplicationRecord
  belongs_to :user

  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :url,
            format: { with: %r{\Ahttps?://} },
            allow_blank: true

  has_many :comments

  def comment_count
    comments.length
  end
end
