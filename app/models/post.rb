class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> {order(created_at: :desc)}, dependent: :destroy # orderメソッドは、関連付けられたオブジェクトに与えられる順序を指定します。内部的にはSQLのORDER BY句が使われる

  accepts_nested_attributes_for :photos

  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: id) # user_idとpost_idが一致するlikeを探し、なければnilを返す
  end
end
