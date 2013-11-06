class BlogComment < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :comment, presence: true
  belongs_to :blog_post
  belongs_to :user


  def updated?
    self.created_at != self.updated_at
  end


end