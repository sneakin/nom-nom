require 'nom_nom'

class Bitter
  include NomNom::Service

  def initialize(url, user, pass)
    super(url, user, pass, Bitter)
  end

  resources :bits
  resources :users

  class Bit
    include NomNom::Resource

    attr_accessor :id, :body, :user_id, :created_on, :updated_on
    belongs_to :user
  end

  class User
    include NomNom::Resource

    attr_accessor :id, :login
    has_many :bits
  end
end
