class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @like = current_user.likes.build(like_params) # モデルを関連付けして、newインスタンスを作成
    @post = @like.post # @likeに紐づく投稿の情報を持ってくる
    if @like.save
      respond_to :js # リアルタイムでビューを反映させるためにフォーマットをJS形式でレスポンスを返す
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @post = @like.post
    if @like.destroy
      respond_to :js
    end
  end

  private
    def like_params
      params.permit(:post_id) # paramsとは送られてきたリクエスト情報をひとまとめにしたもの。permitで変更を加えられるキーを指定。
    end
end
