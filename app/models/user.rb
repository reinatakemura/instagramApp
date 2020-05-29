class User < ApplicationRecord
  has_many :posts, dependent: :destroy  # オブジェクトが削除されるときに、関連付けられたオブジェクトのdestroyメソッドが実行
  has_many :likes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true, length: { maximum: 50 }

  def update_without_current_password(params, *options)  #<% passwordなしで編集を可能にする %>
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)  #<% key に対応する要素を取り除く %>
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)  #<% 引数で指定したHashオブジェクトで更新 %>
    clean_up_passwords  #<% Object.passwordとpassword_confirmationの値をnilにする %>
    result
  end
end
