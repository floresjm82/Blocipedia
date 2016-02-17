class Wiki < ActiveRecord::Base
  
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  scope :publicly_viewable, -> {where(private: false || nil)}

  def public?
    !private
  end
end
