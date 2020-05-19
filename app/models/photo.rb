class Photo < ApplicationRecord
  belongs_to :post

  validates :image, presence: true # 写真がない場合は投稿できない
end
