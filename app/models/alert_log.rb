class AlertLog < ActiveRecord::Base
  belongs_to :alert, touch: true, autosave: true

  def self.per_page
    10
  end
end
