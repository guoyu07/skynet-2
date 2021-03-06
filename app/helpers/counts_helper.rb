module CountsHelper
  def pretty_integer(integer)
    return '0' if integer.nil? || integer == 0
    if integer > 999 && integer <= 999_999
      ('%.1f K' % (integer / 1000.0)).sub('.0', '')
    elsif integer > 999_999 && integer <= 999_999_999
      ('%.1f M' % (integer / 1_000_000.0)).sub('.0', '')
    elsif integer > 999_999_999
      ('%.1f B' % (integer / 1_000_000_000.0)).sub('.0', '')
    else
      integer.to_s
    end
  end
end
