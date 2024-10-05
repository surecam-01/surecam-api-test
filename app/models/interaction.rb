class Interaction < ApplicationRecord
  belongs_to :user

  TYPE_NAMES =  %w[Post Comment]

  validates_presence_of :user, presence: true, if: :user_id
  validate :parent_post_integrity, if: :parent_interaction_id

  validate :ensure_post_is_not_comment
  validate :ensure_comment_is_not_post

  before_save :set_sanitized

  def set_sanitized
    self.sanitized = sanitizer(self.raw)
  end

  def sanitizer(raw)
    rails_sanitizer = Rails::HTML5::FullSanitizer.new 
    rails_sanitizer.sanitize(raw)
  end

  def ensure_post_is_not_comment
    self.errors.add(:base, 'Post has Parent Post') if self.type == TYPE_NAMES[0] && self.parent_interaction_id.nil? == false
  end

  def ensure_comment_is_not_post
    self.errors.add(:base, 'Comment requires Parent Post') if (self.type == TYPE_NAMES[1] && self.parent_interaction_id.nil? == true)
  end

  def parent_post_integrity
    self.errors.add(:base, 'Parent Post does not exist') if !Interaction.exists?(self.parent_interaction_id)
  end
 
  def self.delete_all_descendents(id)
    count = 0
    queue = Comment.where(:parent_interaction_id => id).ids
    count += queue.length
    done = false
    while !done do
      descendent_comments = Comment.where(:parent_interaction_id => queue.shift)
      queue += descendent_comments.ids
      count += descendent_comments.ids.length

      descendent_comments.delete_all

      if queue.length == 0
        done = true
      end

    end  
    count
  end  

end
