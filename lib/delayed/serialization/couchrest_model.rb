require 'couchrest_model'

#extent couchrest to handle delayed_job serialization.
class CouchRest::Model::Base
  yaml_as "tag:ruby.yaml.org,2002:CouchRest"
  
  def self.yaml_new(klass, tag, val)
    klass.get(val['_id'])
  end
  def to_yaml_properties
    ['@id']
  end
  def ==(other)
    if other.is_a? ::CouchRest::Model::Base
      self['_id'] == other['_id']
    else
      super
    end
  end
end