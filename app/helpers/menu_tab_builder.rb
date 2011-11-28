class MenuTabBuilder < TabsOnRails::Tabs::Builder
  def tab_for(tab, name, options, item_options = {})
    item_options[:class] = "active" if current_tab?(tab)
    @context.content_tag(:li, item_options) do
      @context.link_to(name, options)
    end
  end

  def open_tabs
    @context.tag('ul', {:class => 'wat-cf'}, open = true)
  end

  def close_tabs
    "</ul>".html_safe
  end
end
