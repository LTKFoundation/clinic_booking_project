class Admins::UsersController < Admins::AdminController
  before_action :authenticate_admin!

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end


end
