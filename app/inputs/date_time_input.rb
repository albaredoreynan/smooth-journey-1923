class DateTimeInput < SimpleForm::Inputs::DateTimeInput
  def input
    input_html_options.merge! :class => :datepicker
    @builder.text_field(attribute_name, input_html_options)
  end
end
