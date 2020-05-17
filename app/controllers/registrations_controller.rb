class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  def after_update_path_for(resource)  # Deviseが用意しているメソッド。アカウントをアップデートさせた後、どのパスに遷移させるかを指定できる。
    user_path(resource)
  end
end
