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
