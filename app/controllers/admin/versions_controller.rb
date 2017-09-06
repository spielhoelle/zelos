module Admin
  class VersionsController < ApplicationController
    before_action :authenticate_user!

    def index
      @versions = PaperTrail::Version.order('created_at DESC')
      @title = "Versions"
    end


    def remove_all
      PaperTrail::Version.delete_all

      flash[:notice] = "You cleared the history!"
      redirect_to admin_versions_path
    end
  end
end
