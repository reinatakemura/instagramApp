class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> {order(created_at: :desc)}, dependent: :destroy # orderメソッドは、関連付けられたオブジェクトに与えられる順序を指定します。内部的にはSQLのORDER BY句が使われる

  accepts_nested_attributes_for :photos
end
