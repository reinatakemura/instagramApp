class PostsController < ApplicationController
  before_action :authenticate_user!  # 投稿された画像はサインインしたユーザーのみに見える

  def index
    # gem kaminariにて、ページごとに10投稿ずつ表示するようにする
    @posts = Post.limit(10).includes(:photos, :user).order('created_at DESC') # 関連するテーブルをまとめて取得するincludesメソッド
  end

  def new
    @post = Post.new
    @post.photos.build  # モデルを関連付けして、newインスタンスを作成
  end

  def create
    @post = Post.new(post_params)
    if @post.photos.present?
      @post.save
      redirect_to root_path
      flash[:notice] = "投稿が保存されました"
    else
      redirect_to root_path
      flash[:notice] = "投稿に失敗しました"
    end
  end

  def show
    @post = Post.find_by(id: params[:id]) # 受け取ったHTTPリクエストからidを判別し、指定のレコード1つを@postに代入
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.user == current_user # 投稿したユーザーと現在サインインしているユーザーが等しければ、真を返す条件式
      flash[:notice] = "投稿が削除されました" if @post.destroy
    else
      flash[:alert] = "投稿の削除に失敗しました"
    end
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
  end
end
