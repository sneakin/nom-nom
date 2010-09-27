require 'nom_nom'

class Syncd
  include NomNom::Service

  def initialize(subdomain, user, pass)
    super("https://#{subdomain}.syncd.com", user, pass)
  end

  resources :activities
  resources :jobs
  resources :job_types
  resources :time_entries
  resources :users

  def time_entry_summary(query = Hash.new)
    get("/time_entries/summary.xml", :query => query)['time_summary']
  end

  class Activity
    include NomNom::Resource

    attr_accessor :id, :name, :active, :code, :description, :url, :created_at, :updated_at

    has_many :time_entries
  end

  class TimeEntry
    include NomNom::Resource

    attr_accessor :id, :duration, :start_time, :end_time, :note, :user_id, :job_id, :activity_id, :created_at, :updated_at

    belongs_to :user
    belongs_to :job
    belongs_to :activity
  end

  module Ancestors
    def ancestors
      return [ self, *parent.ancestors ] if parent_id
      return [ self ]
    end
  end

  class Job
    include NomNom::Resource
    include Ancestors

    attr_accessor :id, :job_type_id, :parent_id, :name, :code, :description, :url, :active, :effectively_active, :allow_time_entries, :allow_expense_entries, :assigned

    belongs_to :job_type
    belongs_to :parent, :class_name => self.name.demodulize, :key => :parent_id
  end

  class JobType
    include NomNom::Resource
    include Ancestors

    attr_accessor :id, :parent_id, :name, :name_plural, :allow_time_entries, :allow_expense_entries, :show_codes, :show_links, :show_descriptions, :levels

    belongs_to :parent, :class_name => self.name.demodulize
    has_many :children, :class_name => self.name.demodulize, :key => :parent_id
  end

  class User
    include NomNom::Resource

    attr_accessor :id, :name, :first_name, :last_name, :active, :code, :email, :url, :created_at, :updated_at

    has_many :time_entries
  end
end
