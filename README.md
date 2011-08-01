# delayed_job Couchrest Model backend

## Installation

Add the gems to your Gemfile:

    gem 'delayed_job'
    gem 'delayed_job_couchrest_model'
  
If you're using dm-rails gem, add this to your environment.rb:

    XXX::Application::configure do
     config.after_initialize do 
       Delayed::Worker.backend.auto_upgrade!
     end
    end

Otherwise, add an initializer:

    Delayed::Worker.backend.auto_upgrade!

That's it. Use [delayed_job as normal](http://github.com/collectiveidea/delayed_job).