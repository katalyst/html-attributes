# HTML Attributes Utilities

This is a small library intended to make it easier to deal with HTML
attributes in View Components. It is based on 
https://github.com/x-govuk/html-attributes-utils

It uses refinements for `Hash` that allow:

* deep merging while protecting default values from being overwritten
* tidying hashes by removing key/value pairs that have empty or nil values

## Example use

```ruby
class MyViewComponent < ViewComponent::Base
  include Katalyst::HtmlAttributes
  
  def initialize(**html_attributes)
    super
  end
  
  def call
    tag.div(**html_attributes)
  end

  def default_html_attributes
    {
      class: "my-class"
    }
  end
end
```

You can also define your own named attributes:

```ruby
class MyViewComponent < ViewComponent::Base
  include Katalyst::HtmlAttributes
  
  define_html_attributes :link_attributes, :button_attributes
  
  def initialize(link:, button:, **html_attributes)
    super(**html_attributes)
    
    update_link_attributes(**link) if link
    update_button_attributes(**button) if button
  end
  
  def call
    tag.div(**html_attributes) do
      tag.a(**link_attributes) do
        "Link"
      end +
      tag.button(**button_attributes) do
        "Button"
      end       
    end
  end

  def default_html_attributes
    {
      class: "my-class"
    }
  end

  def default_link_attributes
    {
      class: "my-link"
    }
  end

  def default_button_attributes
    {
      class: "my-button"
    }
  end
end
```
