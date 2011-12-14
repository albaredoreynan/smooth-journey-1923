class Supplier < ActiveRecord::Base

  validates :name, :presence => true
  validates :email, :format => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                    :allow_blank => true

  belongs_to :company
end
