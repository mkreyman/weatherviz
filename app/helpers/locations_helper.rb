module LocationsHelper

  def country(location)
    if location['country'] == 'United States of America'
      'USA'
    else
      location['country']
    end
  end

end
