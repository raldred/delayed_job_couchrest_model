# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name              = 'delayed_job_couchrest_model'
  s.version           = '0.1.0'
  s.authors           = ["Rob Aldred"]
  s.summary           = 'Couchrest Model backend for DelayedJob'
  s.description       = 'Couchrest Model backend for DelayedJob'
  s.email             = ['hello@robaldred.co.uk']
  s.extra_rdoc_files  = 'README.md'
  s.files             = Dir.glob('{lib,spec}/**/*') +
                        %w(LICENSE README.md)
  s.homepage          = 'http://github.com/raldred/delayed_job_couchrest_model'
  s.rdoc_options      = ["--main", "README.md", "--inline-source", "--line-numbers"]
  s.require_paths     = ["lib"]
  s.test_files        = Dir.glob('spec/**/*')

  s.add_runtime_dependency      'couchrest_model',  '~> 1.1'
  s.add_runtime_dependency      'delayed_job',   '~> 2.1.0'
  # s.add_runtime_dependency      'delayed_job',   '3.0.0.pre'
  
  s.add_development_dependency  'rspec',          '~> 2.0'
  s.add_development_dependency  'rake'
end