module Admin
  class SettingsController < ApplicationController
    before_action :get_setting, only: [:edit, :update]
    before_action :authenticate_user!

    def index
      @settings = Setting.get_all
      @title = "Settings"
    end

    def edit; end

    def update
      new_value = params[:setting][:value].sub(/^https?\:\/\/(www.)?/,'')
      @setting_update = [@setting.var, @setting.value]
      if @setting.value != new_value
        @setting.value = new_value
        respond_to do |format|
          if @setting.save
            @setting_update = [@setting.var, @setting.value]
            #flash[:notice] = 'Setting has been created successfully.'
            flash.now[:notice] = 'Setting has been created successfully.'
            format.html 
            format.js
          else
            render 'edit'
          end
        end
        # redirect_to admin_settings_path, notice: 'Setting has updated.'
      end
    end

    def get_setting
      @setting = Setting.find_by(var: params[:id]) || Setting.new(var: params[:id])
    end

  end
end
