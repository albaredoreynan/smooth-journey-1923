require 'prawn'
module Prawn
  module Rails
    class TemplateHandler
      def self.call(template)
        %Q{
          pdf = Prawn::Document.new
          #{template.source}
          pdf.render
        }
      end
    end
  end
end
ActionView::Template.register_template_handler :prawn, Prawn::Rails::TemplateHandler
