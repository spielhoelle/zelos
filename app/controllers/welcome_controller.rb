class WelcomeController < ApplicationController

  def index
    @title = "Zelos Invoice"
    @entries = Entry.all
    if user_signed_in? 
      redirect_to admin_entries_path
    end
  end

end
