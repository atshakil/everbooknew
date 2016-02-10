class Pin < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  has_and_belongs_to_many :people, class_name: 'User'
  
  serialize :text_marks, Array

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :user, :image, presence: true

end
