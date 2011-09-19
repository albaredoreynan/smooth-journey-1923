class JavascriptsController < ApplicationController
  def dynamic_states
    @subcategories = Subcategory.find(:all)
    
    respond_to do |format|
    format.js
    end
  end

end
