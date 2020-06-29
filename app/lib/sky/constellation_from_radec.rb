# frozen_string_literal: true

class Sky::ConstellationFromRadec
  CONVH = Math::PI / 12.0
  CONVD = Math::PI / 180.0

  CDR = Math::PI / 180.0
  CSR = CDR / 3600.0

  EPOCH = 2000.0
  REF_EPOCH = 1875.0

  def initialize(right_ascension, declination)
    @right_ascension = right_ascension
    @declination = declination
  end

  def constellation
    converted_ra, converted_dec = precess(EPOCH, REF_EPOCH)
    boundary = find_boundary(converted_ra, converted_dec)
    boundary.abbr
  end

  private

  attr_reader :right_ascension, :declination

  def precess(epoch1, epoch2)
    ra1 = right_ascension * CONVH
    dec1 = declination * CONVD

    a = Math.cos(dec1)
    x1 = [
      a * Math.cos(ra1),
      a * Math.sin(ra1),
      Math.sin(dec1),
    ]
    t = 0.001 * (epoch2 - epoch1)
    st = 0.001 * (epoch1 - 1900.0)

    a = CSR * t * (
      23_042.53 + st * (139.75 + 0.06 * st) + t * (30.23 - 0.27 * st + 18.0 * t)
    )
    b = CSR * t * t * (79.27 + 0.66 * st + 0.32 * t) + a
    c = CSR * t * (
      20_046.85 - st * (85.33 + 0.37 * st) + t * (-42.67 - 0.37 * st - 41.8 * t)
    )

    sina = Math.sin(a)
    sinb = Math.sin(b)
    sinc = Math.sin(c)
    cosa = Math.cos(a)
    cosb = Math.cos(b)
    cosc = Math.cos(c)

    matrix = [
      [
        cosa * cosb * cosc - sina * sinb,
        -cosa * sinb - sina * cosb * cosc,
        -cosb * sinc,
      ], [
        sina * cosb + cosa * sinb * cosc,
        cosa * cosb - sina * sinb * cosc,
        -sinb * sinc,
      ], [
        cosa * sinc,
        -sina * sinc,
        cosc,
      ],
    ]

    x2 = matrix.map { |m| m[0] * x1[0] + m[1] * x1[1] + m[2] * x1[2] }

    ra2 = Math.atan2(x2[1], x2[0])
    ra2 += 2.0 * Math::PI if ra2 < 0.0

    dec2 = Math.asin(x2[2])

    [ra2 / CONVH, dec2 / CONVD]
  end

  def find_boundary(ra, dec)
    boundaries.detect do |boundary|
      (dec >= boundary.dec && ra >= boundary.lower_ra && ra < boundary.upper_ra)
    end
  end

  def boundaries
    @boundaries ||= begin
      constellation_boundaries = Sky::ConstellationBoundaries.new
      constellation_boundaries.parse
      constellation_boundaries.boundaries
    end
  end
end
