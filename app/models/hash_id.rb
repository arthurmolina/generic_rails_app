# Abstract Class to use encrypted parameters
class HashId < ActiveRecord::Base
  self.abstract_class = true
  
  def to_param
    Hashids.new( self.class.name, 8 ).encrypt( id )
  end

  def self.find_by_param( input )
    find( Hashids.new( self.name, 8 ).decrypt( input ) ).first
  end
end