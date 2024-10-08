class Todo
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :id
  attribute :userId
  attribute :title
  attribute :completed

  NUMERIC_STRING = /^[0-9]*$/ # allowing for any number
  BOOLEAN_STRINGS = ["true", "false"]
  
end