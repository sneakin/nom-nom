require 'nom_nom'

class Bitter < NomNom::Service
  class Bit < NomNom::Resource
    attr_accessor :id, :body, :user_id, :created_on, :updated_on
    belongs_to :user
  end

  class User < NomNom::Resource
    attr_accessor :id, :login
    has_many :bits
  end

  def initialize(url, user, pass)
    super(url, user, pass, Bitter)
  end

  resources :bits
  resources :users
end
