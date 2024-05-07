# frozen_string_literal: true

require "spec_helper"

RSpec.describe Katalyst::HtmlAttributes do
  subject(:container) do
    Class.new do
      include Katalyst::HtmlAttributes

      def default_html_attributes
        { id: "default-id", class: "default-class", data: { controller: "default" } }
      end
    end.new(**attributes)
  end

  let(:attributes) { { id: "init-id", class: "init-class", data: { controller: "init" } } }

  it "supports merging attributes" do
    expect(container.html_attributes).to eq(
      id:    "init-id",
      class: ["default-class", "init-class"],
      data:  { controller: "default init" },
    )
  end

  it "supports updating attributes" do
    container.update_html_attributes(
      id:    "update-id",
      class: "update",
      data:  { controller: "update" },
    )
    expect(container.html_attributes).to eq(
      id:    "update-id",
      class: ["default-class", "init-class", "update"],
      data:  { controller: "default init update" },
    )
  end
end
