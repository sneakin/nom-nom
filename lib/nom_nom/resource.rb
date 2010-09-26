module NomNom
  module Resource
    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end

    attr_reader :service

    def initialize(service, attrs)
      @service = service

      attrs.each { |attr, value|
        if respond_to?("#{attr}=")
          send("#{attr}=", value)
        else
          $stderr.puts "WARNING: #{attr} is undefined for #{self.class}"
        end
      }
    end

    def ==(other)
      self.id == other.id
    end

    module ClassMethods
      def belongs_to(name, options = {})
        assoc = (options[:class_name] || name).to_s.underscore.pluralize
        key = options[:key] || "#{name}_id"

        define_method(name) do |*args|
          service.send(assoc, *args).find { |r| r.id == send(key) }
        end
      end

      def has_many(name, options = {})
        assoc = (options[:class_name] || name).to_s.underscore.pluralize
        key = options[:key] || "#{self.name.demodulize.underscore}_id"

        define_method(name) do |*args|
          service.send(assoc, *args).select { |r| r.send(key) == id }
        end
      end
    end
  end
end
