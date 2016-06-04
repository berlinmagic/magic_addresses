class AddEarthdistance < ActiveRecord::Migration
  def get_indexes_for_table( table = 'mgca_addresses' )
    ## ActiveRecord indexes .. doesnt include earthdistance, because its build directly in postgres!
    # => ActiveRecord::Base.connection.indexes(:mgca_addresses).map{ |x| x.name }
    # => index_exists?(:mgca_addresses, :earthdistance, name: "mgca_addresses_earthdistance_ix")
    ## Postgres-Indexes .. thanks to: http://www.alberton.info/postgresql_meta_info.html#p13
    execute( "SELECT c.relname AS index_name FROM pg_class AS a JOIN pg_index AS b ON (a.oid = b.indrelid) JOIN pg_class AS c ON (c.oid = b.indexrelid) WHERE a.relname = '#{table}';").map{ |that| that["index_name"] }
  end
  
  def self.up
    
    # comented out to avoid PG::InsufficientPrivilege-ERROR
    # add with cap postgresql:add_extensions
    # => execute "CREATE EXTENSION IF NOT EXISTS cube"
    # => execute "CREATE EXTENSION IF NOT EXISTS earthdistance"
    
    if Rails.env.development? || Rails.env.test?
      enable_extension "cube"
      enable_extension "earthdistance"
    end
    
    unless get_indexes_for_table('mgca_addresses').include?("mgca_addresses_earthdistance_ix")
      add_earthdistance_index :mgca_addresses, lat: 'latitude', lng: 'longitude'
    end
    
    
    ## Want to add indexes to other models?
    ## -- Model needs this mehtod
    ##       acts_as_geolocated lat: 'latitude', lng: 'longitude')
    ## 
    ## i.e.: Job-model:
    ## 
    # => add_column :jobs,   :latitude,      :float
    # => add_column :jobs,   :longitude,     :float
    # => Job.all.each do |that|
    # =>   if that.address && that.address.latitude && that.address.longitude
    # =>     that.latitude   = that.address.latitude
    # =>     that.longitude  = that.address.longitude
    # =>     that.save(:validate => false)
    # =>   end
    # => end
    # => unless get_indexes_for_table('jobs').include?("jobs_earthdistance_ix")
    # =>   add_earthdistance_index :jobs, lat: 'latitude', lng: 'longitude'
    # => end
    
    
  end

  def self.down
    # => execute "DROP EXTENSION IF EXISTS earthdistance"
    # => execute "DROP EXTENSION IF EXISTS cube"
    # comented out in staging and production to avoid PG::InsufficientPrivilege-ERROR .. add with cap postgresql:remove_extensions
    if Rails.env.development? || Rails.env.test?
      disable_extension "earthdistance"
      disable_extension "cube"
    end
    
    
    if get_indexes_for_table('mgca_addresses').include?("mgca_addresses_earthdistance_ix")
      remove_earthdistance_index :mgca_addresses
    end
    
    ## remove from Job
    # => if get_indexes_for_table('jobs').include?("jobs_earthdistance_ix")
    # =>   remove_earthdistance_index :jobs
    # => end
    # => remove_column :jobs,      :latitude,    :float
    # => remove_column :jobs,      :longitude,   :float
    
    
  end
end
