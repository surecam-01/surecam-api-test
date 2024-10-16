class Interaction < ApplicationRecord
  belongs_to :user

  TYPE_NAMES =  %w[Post Comment]

  validates_presence_of :user, presence: true, if: :user_id
  validate :parent_post_integrity, if: :parent_interaction_id

  validate :ensure_post_is_not_comment
  validate :ensure_comment_is_not_post

  before_save :set_sanitized

  def set_sanitized
    self.sanitized = Interaction.sanitizer(self.raw)
  end

  def descendants 
    descendants = Comment.where(:parent_interaction_id => self.id)
    queue = descendants.ids 
    done = false
    while !done do
      nested_descendants = Comment.where(:parent_interaction_id => queue.shift)

      descendants += nested_descendants
      queue += nested_descendants.ids

      if queue.length == 0
        done = true
      end

    end  
    descendants
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
 
  def self.sanitizer(raw)
    rails_sanitizer = Rails::HTML5::FullSanitizer.new 
    rails_sanitizer.sanitize(raw)
  end

  def self.batch_delete(interactions)

    count = interactions.length

    Interaction.destroy(interactions.map(&:id))

    count

  end  

end
