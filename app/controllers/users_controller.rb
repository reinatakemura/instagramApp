class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id]) # 与えられた条件にマッチする最初のレコードだけを返す
  end
end
