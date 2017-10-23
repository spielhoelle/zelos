class WelcomeController < ApplicationController

  def index
    @title = "Zelos Invoice"
    @entries = Entry.all
  end

end
