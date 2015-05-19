module Statistics


  def time_data data, type = :array
    months = Array.new(13).fill(0)
    days = Array.new(7).fill(0)
    hours = Array.new(24).fill(0)
    data.each do |item|
      months[item.created_at.month-1] += 1
      days[item.created_at.wday] += 1
      hours[item.created_at.hour] += 1
    end
    
    if type == :array
      time = { 
        month_in_year: months,
        days_of_week: days,
        hours: hours
      }
      return time
    elsif type == :hash
      time = { 
        month_in_year: Hash[Date::MONTHNAMES.zip months],
        days_of_week: Hash[Date::DAYNAMES.zip days],
        hours: Hash[(0..23).zip hours]
      }
      return time
    end
  end


  def word_cloud array, options = {}
    options[:split] = true if options[:split].nil?
    options[:limit] = 200 if options[:limit].nil?

    if options[:split]
      array.map! {|x| x.split(' ')}
    else
      array.map! {|x| [x]}
    end

    cloud = Hash.new(0)
    i = 0
    while i < array.length
      array[i].each do |x|
        word = x.downcase.tr('^a-z', '') if x
        cloud[word] += 1 if x and !word.empty?
      end
      i += 1
    end
    return cloud.sort_by {|k,v| v}.reverse[0..options[:limit]]
  end


end