module NomNom
  module Service
    def self.included(base)
      base.class_eval do
        include HTTParty
        extend ClassMethods
      end
    end

    attr_reader :auth, :module

    def initialize(uri, user, pass, mod = self.class.name)
      self.class.base_uri uri
      @auth = { :username => user, :password => pass } if user
      @module = mod.to_s.camelize
    end

    def get(path, options = Hash.new)
      self.class.get(path, { :basic_auth => @auth }.merge(options))
    end

    module ClassMethods
      def resources(name, options = Hash.new)
        name = name.to_s
        path = options[:path] || "/#{name}.xml"

        define_method(name) do |*args|
          query = args.extract_options!
          reload = args[0] || false

          if !query.empty? || reload || instance_variable_get("@#{name}") == nil
            resources = get_resources(path, query, name)

            if query.empty?
              instance_variable_set("@#{name}", resources)
            else
              return resources
            end
          end

          instance_variable_get("@#{name}")
        end
      end
    end

    protected
    def get_resources(path, query, resource)
      klass = ("#{@module}::" + resource.to_s.singularize.camelize).constantize

      self.
        get(path, :query => query)[resource].
        collect { |r| klass.new(self, r) }
    end
  end
end
