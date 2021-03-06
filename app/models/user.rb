class User < ActiveRecord::Base
  belongs_to :rol
  has_many :ordenes_servicios
  belongs_to :agente
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :registerable,
  devise :database_authenticatable,:recoverable, :rememberable, :trackable, :validatable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :rol_id, :agente_id
  validates_associated :agente 
  # attr_accessible :title, :body
  #
  def admin?
    self.rol and self.rol.nombre == 'administrador'
  end

  def capturista?
    self.rol and self.rol.nombre == 'capturista'
  end

  def responsable_nave?
    self.rol and self.rol.nombre == 'responsable de nave'
  end

  def tecnico?
    self.ron and self.rol.nombre == 'tecnico'
  end
end
