class WelcomeController < ApplicationController

  def index
    @entries = Entry.all
  end

end
