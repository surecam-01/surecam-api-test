# Load the Rails application.
require_relative "application"


db_variables = File.join(Rails.root, 'config', 'secret_variables.rb')
load(db_variables) if File.file?(db_variables)

# Initialize the Rails application.
Rails.application.initialize!
