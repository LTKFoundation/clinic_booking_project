class Admins::RegistrationsController < Devise::RegistrationsController

    protected

      def after_update_path_for(resource)
          flash[:notice] = "Account succesfully updated"
          edit_admin_registration_path
      end
end
