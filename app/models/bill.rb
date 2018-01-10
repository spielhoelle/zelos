class Bill < ActiveRecord::Base
  validates :title, :price, presence: true
  has_paper_trail :ignore => [:created_at, :updated_at]

  has_attached_file :image,
    default_url: 'fallback.jpg',
    styles: {
      thumbnail: '168x300^',
      medium: '600x1060^',
      original:     '900x1600^'},
      :convert_options => {
        :thumbnail => "-quality 75 -strip",
        :medium => "-quality 75 -strip",
        :original => "-quality 75 -strip"}


    validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] }


end
