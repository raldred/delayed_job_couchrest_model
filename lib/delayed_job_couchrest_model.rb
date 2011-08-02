require 'couchrest_model'
require 'delayed_job'
require 'delayed/serialization/couchrest_model'
require 'delayed/backend/couchrest_model'
Delayed::Worker.backend = Delayed::Backend::CouchrestModel::Job
Delayed::Backend::CouchrestModel::Job.use_database ::CouchRest.database('delayed_job')