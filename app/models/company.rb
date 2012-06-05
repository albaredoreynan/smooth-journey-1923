class Company < ActiveRecord::Base

  DEFAULT_SETTINGS = { :enable_lock_module => false, :lock_module_in => 0 }

  serialize :settings, Hash

  validates :name, :presence => true

  after_initialize :set_default_settings

  has_many :restaurants, :dependent => :destroy

  def settings=(options)
    options.each do |key, val|
      break unless DEFAULT_SETTINGS.keys.include? key.to_sym
      key = key.to_sym
      val = case key
            when :enable_lock_module then to_bool(val)
            when :lock_module_in then Integer val
            end
      self.settings[key] = val
    end
  end

  private
  def set_default_settings
    self.settings = DEFAULT_SETTINGS if self.settings.empty?
  end

  def to_bool(val)
    return true if val == true || val =~ (/t|y|1$/i)
    return false if val == false || val.blank? || val =~ (/f|n|0$/i)
    raise ArgumentError.new("Invalid value for boolean: \"#{val}\"")
  end

end
