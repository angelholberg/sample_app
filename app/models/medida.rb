class Medida < ActiveRecord::Base
  validates :clave, :presence => true, :length => {:maximum => 20, :minimum => 3}, :uniqueness => { :message => "La clave ya existe!"  }
  has_many :articulos_medidas
  has_many :articulos, :through => :relaciones_articulos_medidas
  attr_accessible :clave, :descripcion
end
