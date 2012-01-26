class Company < ActiveRecord::Base

  DEFAULT_SETTINGS = { :enable_lock_module => false, :lock_module_in => 0 }

  serialize :settings, Hash

  validates :name, :presence => true

  after_initialize :set_default_settings

  has_one :setting
  has_many :restaurants

  private
  def set_default_settings
    self.settings = DEFAULT_SETTINGS if self.settings.empty?
  end
end
