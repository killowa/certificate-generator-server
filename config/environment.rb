# Load the Rails application.
ENV["port"] = "3030"
ENV["secret_key"] = "secret"

require_relative "application"


# Initialize the Rails application.
Rails.application.initialize!
