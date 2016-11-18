class Admins::HomeController < Admins::AdminController
  before_action :authenticate_admin!

  def index
  end

end
