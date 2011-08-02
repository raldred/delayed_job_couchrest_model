$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'logger'

require 'delayed_job_couchrest_model'
require 'delayed/backend/shared_spec'

COUCHHOST = "http://127.0.0.1:5984"
TESTDB    = 'delayed_job_spec'
TEST_SERVER    = CouchRest.new COUCHHOST
TEST_SERVER.default_database = TESTDB
DB = Delayed::Backend::CouchrestModel::Job.use_database(TEST_SERVER.database(TESTDB))

RSpec.configure do |config|
  config.before(:all) { reset_test_db! }

  # config.after(:all) do
  #   cr = TEST_SERVER
  #   test_dbs = cr.databases.select { |db| db =~ /^#{TESTDB}/ }
  #   test_dbs.each do |db|
  #     cr.database(db).delete! rescue nil
  #   end
  # end
end

class Story < CouchRest::Model::Base
  use_database DB
  
  property :text

  def tell; text; end
  def whatever(n, _); tell*n; end

  handle_asynchronously :whatever
end

def reset_test_db!
  DB.recreate! rescue nil 
  # Reset the Design Cache
  Thread.current[:couchrest_design_cache] = {}
  DB
end

