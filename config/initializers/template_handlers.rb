require 'prawn'
require 'prawn/layout'
require 'prawn/table'
module Prawn
  module Rails
    class TemplateHandler
      def self.call(template)
        %Q{
          pdf = Prawn::Document.new :skip_page_creation => true
          #{template.source}
          pdf.render
        }
      end
    end
  end
end
ActionView::Template.register_template_handler :prawn, Prawn::Rails::TemplateHandler
