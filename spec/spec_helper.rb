require 'rspec/rails'

def json(body)
  JSON.parse(body, symbolize_names: true)
end
RSpec.configure do |config|
end
