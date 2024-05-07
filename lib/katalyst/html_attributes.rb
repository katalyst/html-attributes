# frozen_string_literal: true

require_relative "html_attributes/has_html_attributes"

module Katalyst
  module HtmlAttributes
    extend ActiveSupport::Concern

    using HasHtmlAttributes

    def self.options_to_html_attributes(options)
      options.slice(:id, :aria, :class, :data).merge_html(options.fetch(:html, {}))
    end

    class_methods do
      def define_html_attribute_methods(name, default: {})
        define_method(:"default_#{name}") { default }
        private(:"default_#{name}")

        define_method(name) do
          send(:"default_#{name}").merge_html(instance_variable_get(:"@#{name}") || {})
        end

        define_method(:"#{name}=") do |options|
          instance_variable_set(:"@#{name}", HtmlAttributes.options_to_html_attributes(options))
        end

        define_method(:"update_#{name}") do |**options, &block|
          attributes = instance_variable_get(:"@#{name}") || {}
          attributes = attributes.merge_html(HtmlAttributes.options_to_html_attributes(options))
          attributes = yield(attributes) if block
          instance_variable_set(:"@#{name}", attributes)
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
  end
end
