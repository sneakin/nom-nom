require 'nom_nom'

class Bitter
  include NomNom::Service

  def initialize(url, user, pass)
    super(url, user, pass)
  end

  resources :bits
  resources :users

  class Bit < Struct.new(:id, :body, :user_id, :created_on, :updated_on)
    include NomNom::Resource
    belongs_to :user
  end

  class User < Struct.new(:id, :login)
    include NomNom::Resource
    has_many :bits
  end
end
