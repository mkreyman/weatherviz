module LocationsHelper

  def country(location)
    if location['country'] == 'United States of America'
      'US'
    else
      location['country']
    end
  end

end
