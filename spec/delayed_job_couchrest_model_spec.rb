require 'spec_helper'

describe Delayed::Backend::CouchrestModel::Job do
  
  # let(:worker) { Delayed::Worker.new }
  # 
  # def create_job(opts = {})
  #   described_class.create(opts.merge(:payload_object => SimpleJob.new))
  # end
  # 
  # before do
  #   Delayed::Worker.max_priority = nil
  #   Delayed::Worker.min_priority = nil
  #   Delayed::Worker.default_priority = 99
  #   Delayed::Worker.delay_jobs = true
  #   SimpleJob.runs = 0
  #   described_class.delete_all
  # end
  # 
  
  it_should_behave_like 'a delayed_job backend'
end