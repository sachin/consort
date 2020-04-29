module Consort
  module Mongoid
    module ActiveRecord
      extend ActiveSupport::Concern

      module ClassMethods
        # Defines a `has_one` relationship with an ActiveRecord object.
        # @param klass [Symbol]
        # @example
        #   has_one_active_record :dolphin
        def has_one_active_record(klass, **options)
          if options[:as]
            class_eval <<-CODE
              def #{klass}
                #{klass.to_s.classify}.where(#{options[:as].to_s}_id: id, #{options[:as].to_s}_type: #{name}).take
              end
            CODE
          else
            class_eval <<-CODE
              def #{klass}
                #{klass.to_s.classify}.where(#{name.foreign_key}: id).take
              end
            CODE
          end
        end

        # Defines a `has_many` relationship with an ActiveRecord object.
        # @param klass [Symbol]
        # @example
        #   has_many_active_record :unicorns
        # @since 0.0.2
        def has_many_active_record(klass, **options)
          if options[:as]
            class_eval <<-CODE
              def #{klass}
                #{klass.to_s.classify}.where(#{options[:as].to_s}_id: id, #{options[:as].to_s}_type: #{name})
              end
            CODE
          else
            class_eval <<-CODE
              def #{klass}
                #{klass.to_s.classify}.where(#{name.foreign_key}: id)
              end
            CODE
          end
        end

        # Defines a `belongs_to` relationship with an ActiveRecord object.
        # An appropriate foreign key field must exist on your model.
        # @param klass [Symbol]
        # @example
        #   class Narwhal
        #     include Mongoid::Document
        #
        #     belongs_to_active_record :pod
        #     field :pod_id, type: Integer
        #   end
        def belongs_to_active_record(klass, **options)
          if options[:polymorphic]
            class_eval <<-CODE
              def #{klass}
                #{klass.to_s}_type.constantize.where(id: #{klass.to_s}_id)
              end
            CODE
          else
            class_eval <<-CODE
              def #{klass}
                #{klass.to_s.classify}.where(id: #{klass.to_s.foreign_key})
              end
            CODE
          end
        end

        # Allows easy validation of whether Mongoid to ActiveRecord bridge is
        # loaded.
        # @return [Boolean] `true` if bridge is loaded
        def mongoid_consorts_with_active_record?
          true
        end
      end
    end
  end
end

module Mongoid::Document
  include Consort::Mongoid::ActiveRecord
end
