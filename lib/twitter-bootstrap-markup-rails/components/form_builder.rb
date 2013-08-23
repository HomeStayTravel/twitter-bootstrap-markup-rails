module Twitter::Bootstrap::Markup::Rails::Components
  class FormBuilder < ActionView::Helpers::FormBuilder

    def text_field(method, options={})
      input_html = super(method, options.except(:label, :label_text))
      Form::InputField.new(object_name, method, input_html, options).to_s
    end

    def number_field(method, options={})
      input_html = super(method, options.except(:label, :label_text))
      Form::NumberField.new(object_name, method, input_html, options).to_s
    end

    def text_area(method, options={})
      input_html = super(method, options.except(:label, :label_text))
      Form::TextArea.new(object_name, method, input_html, options).to_s
    end

    def password_field(method, options={})
      input_html = super(method, options.except(:label, :label_text))
      Form::InputField.new(object_name, method, input_html, options).to_s
    end

    def radio_button(method, tag_value, options={})
      # TODO As is all of the options passed in end up as tags in the output
      # html. We should probably fix this.
      element_html = super(method, tag_value, options.except(:label, :label_text))
      Form::RadioButton.new(object_name, method, tag_value, element_html, options).to_s
    end

    def select(method, choices, options={}, html_options={})
      element_html = super(method, choices, options.except(:label, :label_text), html_options)
      Form::Select.new(object_name, method, element_html, options).to_s
    end

    def check_box(method, options={})
      element_html = super(method, options.except(:label, :label_text))
      Form::CheckBox.new(object_name, method, element_html, options).to_s
    end

    def file_field(method, options={})
      element_html = super(method, options.except(:label, :label_text))
      Form::FileField.new(object_name, method, element_html, options).to_s
    end

    def telephone_with_country_code_field(method, country_codes, options = {})
      country_code_method = "#{method}_country_code"
      country_code_select = @template.select(object_name, country_code_method, country_codes, options.merge(include_blank: "Country Code"), {:class => 'telephone_field_country_code'}).to_s

      telephone_number_method = "#{method}_number"

      obj = @object || @template.instance_variable_get("@#{object_name}")
      phone_number = obj.send(telephone_number_method)

      telephone_field = @template.telephone_field(object_name, telephone_number_method, options.except(:label, :label_text, :class).merge(:value => phone_number, :class => 'telephone_field_number'))
      element_html = @template.content_tag(:div, country_code_select + telephone_field, :class => "#{options[:class]} telephone_field_container")
      Form::InputField.new(object_name, method, element_html, options).to_s
    end

    def button(value, options={})
      Form::Button.new(object_name, value, options.except(:label, :label_text)).to_s
    end
  end
end
