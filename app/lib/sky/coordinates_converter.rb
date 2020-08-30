# frozen_string_literal: true

class Sky::CoordinatesConverter
  SEPARATOR = ":"
  DIGITS_PRECISION = 6

  MINUTES_IN_HOUR = 60
  SECONDS_IN_HOUR = 3600

  def initialize(coordinates)
    @coordinates = coordinates
  end

  def convert
    f, m, s = @coordinates.split(SEPARATOR).map(&:to_d)
    (f + m / MINUTES_IN_HOUR + s / SECONDS_IN_HOUR).ceil(DIGITS_PRECISION)
  end
end
