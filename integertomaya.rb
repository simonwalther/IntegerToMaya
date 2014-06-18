module IntegerToMaya
  def integer_to_maya(number)
    result = ""
    @converter ||= Converter.new
    @converter.verify(number)
    @converter.convert(number)
  end
end

class Converter

  def convert(number)
    number = number.to_i
    maya_number = ""
    maya_number << write_floor(number)

    return maya_number
  end

  def write_circle(number)
    #### this method has for goal to write the circle ###
    # we %5 the argumment value because circles are what we did not manage to write in bar
    # a circle is display by "o"

    result = ""

    (number%5).times do
      result << "o"
    end

    return result
  end

  def write_bar(number)
    #### this method has for goal to write the bar ###
    # we /5 the argumment value because a bar have a value of 5
    # a bar is display by "\n-----"
    # if there's only one bar we display it by "-----"

    result = ""

    if number != 5
      (number/5).times do
        result << "\n-----"
      end
    else
      result << "-----"
    end

    return result
  end

  def write_floor(number)
    #### this method has for goal to write floors made up of circles and bars ###
    # the number of floors = the number of time we can /20 the number +1
    # to have the value of this floor:
    # we substract the already calculated amount and divide it by 20^this_flor
    # we puts two endlines between floors
    # we write an "<(((>" if the number to write is equal to 0
    # eg: 283
    # 283/20 = 14     => 2 floors
    # first floor     => (283-0)/(20^1) = 14 = ooo\n-----\n-----
    # between floors  => \n\n
    # counted         => 14*(20^1) = 280
    # second floor    => (283-280)/(20^0) = 3 = ooo
    # result might be => ooo\n-----\n-----\n\nooo

    result = ""
    floor = 1
    cp_number = number
    counted = 0

    while cp_number >= 20
      cp_number = (cp_number/20)
      floor += 1
    end

    floor.downto(0) do |this_floor|
      number_to_write = (number-counted)/(20**this_floor)

      if (floor-this_floor) > 1
        result << "\n\n"

        if number_to_write == 0
          result << "<(((>"
        end
      end

      result << write_circle(number_to_write)
      result << write_bar(number_to_write)

      counted += number_to_write*(20**this_floor)
    end

    return result
  end

  def verify(number)
    if number.split.any? { |val| /^\D/ =~ val } || number.split.empty?
      raise "only digit characters are allowed"
    end
  end
end
