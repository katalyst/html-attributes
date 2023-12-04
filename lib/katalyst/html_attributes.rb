# frozen_string_literal: true

require_relative "html_attributes/has_html_attributes"

module Katalyst
  module HtmlAttributes
    extend ActiveSupport::Concern

    class_methods do
      using HasHtmlAttributes

      def define_html_attribute_methods(name, default: {})
        define_method("default_#{name}") { default }
        private("default_#{name}")

        define_method(name) do
          send("default_#{name}").merge_html(instance_variable_get("@#{name}") || {})
        end

        define_method("#{name}=") do |options|
          instance_variable_set("@#{name}", options.slice(:id, :aria, :class, :data).merge(options.fetch(:html, {})))
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
