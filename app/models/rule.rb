class Rule < ActiveRecord::Base
  belongs_to :alert

  def message(weather_report)
    field = self.field
    operator = self.operator
    # Need to calculate value based on field type...
    # temperature fields only for now.
    value = self.value.to_i
    value_converted = (value + 459.67) * 5 / 9
    something_to_tell = case
      when operator == '>'
        weather_report.send(field) > value_converted
      when operator == '='
        weather_report.send(field) == value_converted
      when operator == '<'
        weather_report.send(field) < value_converted
                        end
    if something_to_tell
      "#{field} is #{operator} #{value}"
    end
  end

end
