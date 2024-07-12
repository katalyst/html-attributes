# frozen_string_literal: true

require "active_support"
require "active_support/rails"

module Katalyst
  module HtmlAttributes
    extend ActiveSupport::Autoload
    extend ActiveSupport::Concern

    autoload :HasHtmlAttributes

    using HasHtmlAttributes

    class_methods do
      def define_html_attribute_methods(name, default: {})
        ivar = :"@#{name}"
        default_method = :"default_#{name}"
        define_method(default_method) { default.deep_dup }
        private(default_method)

        define_method(name) do
          html_attributes_get(ivar, default_method)
        end

        define_method(:"#{name}=") do |options|
          html_attributes_set(ivar, options)
        end

        define_method(:"update_#{name}") do |**options, &block|
          html_attributes_update(ivar, options, &block)
        end
      end
    end

    included do
      define_html_attribute_methods :html_attributes, default: {}
    end

    def initialize(**options)
      super(**options.except(:id, :aria, :class, :data, :html))

      self.html_attributes = options
    end

    def options_to_html_attributes(options)
      options.slice(:id, :aria, :class, :data).merge_html(options.fetch(:html, {}))
    end
    module_function(:options_to_html_attributes)

    private

    def html_attributes_get(ivar, default)
      if instance_variable_defined?(ivar)
        send(default).merge_html(instance_variable_get(ivar))
      else
        send(default)
      end
    end

    def html_attributes_set(ivar, options)
      instance_variable_set(ivar, options_to_html_attributes(options))
    end

    def html_attributes_update(ivar, options, &block)
      attributes = instance_variable_get(ivar) || {}
      attributes = attributes.merge_html(options_to_html_attributes(options))
      attributes = yield(attributes) if block
      instance_variable_set(ivar, attributes)
    end
  end
end
