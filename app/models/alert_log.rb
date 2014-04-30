class AlertLog < ActiveRecord::Base
  belongs_to :alert, touch: true, autosave: true
end
