require 'spec_helper'

describe Delayed::Backend::CouchrestModel::Job do
  
  let(:worker) { Delayed::Worker.new }
  
  def create_job(opts = {})
    described_class.create(opts.merge(:payload_object => SimpleJob.new))
  end
  
  before do
    Delayed::Worker.max_priority = nil
    Delayed::Worker.min_priority = nil
    Delayed::Worker.default_priority = 99
    Delayed::Worker.delay_jobs = true
    SimpleJob.runs = 0
    described_class.delete_all
  end
  
  describe "reserve" do
    before do
      Delayed::Worker.max_run_time = 2.minutes
    end
  
    it "should not reserve failed jobs" do
      create_job :attempts => 50, :failed_at => described_class.db_time_now
      described_class.reserve(worker).should be_nil
    end
  
    it "should not reserve jobs scheduled for the future" do
      create_job :run_at => described_class.db_time_now + 5.minutes
      puts described_class.db_time_now + 5.minutes
      described_class.reserve(worker).should be_nil
    end
  
    it "should reserve jobs scheduled for the past" do
      job = create_job :run_at => described_class.db_time_now - 1.minute
      described_class.reserve(worker).should == job
    end
  
    it "should reserve jobs scheduled for the past when time zones are involved" do
      Time.zone = 'US/Eastern'
      job = create_job :run_at => described_class.db_time_now - 1.minute.ago.in_time_zone
      described_class.reserve(worker).should == job
    end
  
    it "should not reserve jobs locked by other workers" do
      job = create_job
      other_worker = Delayed::Worker.new
      other_worker.name = 'other_worker'
      described_class.reserve(other_worker).should == job
      described_class.reserve(worker).should be_nil
    end
  
    it "should reserve open jobs" do
      job = create_job
      described_class.reserve(worker).should == job
    end
  
    it "should reserve expired jobs" do
      job = create_job(:locked_by => worker.name, :locked_at => described_class.db_time_now - 3.minutes)
      described_class.reserve(worker).should == job
    end
  
    it "should reserve own jobs" do
      job = create_job(:locked_by => worker.name, :locked_at => (described_class.db_time_now - 1.minutes))
      described_class.reserve(worker).should == job
    end
  end
  
  
  # it_should_behave_like 'a delayed_job backend'
end