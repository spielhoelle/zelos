# RailsSettings Model
class Setting < RailsSettings::Base
  #has_paper_trail :ignore => [:created_at, :updated_at]
  source Rails.root.join("config/app.yml")
  
  namespace Rails.env
end
