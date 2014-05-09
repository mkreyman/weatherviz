class AlertLog < ActiveRecord::Base
  belongs_to :alert, touch: true, autosave: true

  def self.per_page
    10
  end

  def alert_name
    Alert.find(self.alert_id).alert_name
  end
end
