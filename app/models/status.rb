class Status < ActiveRecord::Base
  has_many :issues
  validates :title, presence: true

  def self.options_for_select
    order('id ASC').map { |e| [e.title, e.id] }
  end
end
