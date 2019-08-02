require 'project'
require 'volunteer'
require 'rspec'
require 'pg'
require 'pry'

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM project *;")
    DB.exec("DELETE FROM volunteer *;")
  end
end
