class Todo
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :id
  attribute :userId
  attribute :title
  attribute :completed
  
end