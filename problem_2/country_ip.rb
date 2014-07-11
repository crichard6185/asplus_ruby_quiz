require 'ipaddr'
require 'csv'

class CountryIp
  def search(ip_string)
    raise ArgumentError unless valid_ip_address?(ip_string)

    ip_int = ip_integer(ip_string)

    File.open(filename).readlines.each do |line|
      next if line_is_comment?(line)

      row = CSV.parse(line).first

      from_ip = row[0].to_i
      to_ip = row[1].to_i

      return row[6] if ip_int >= from_ip && ip_int <= to_ip
    end
  end

  def valid_ip_address?(ip_string)
    IPAddr.new(ip_string).ipv4?
  rescue IPAddr::InvalidAddressError
    raise ArgumentError
  end

  def line_is_comment?(line)
    line.match /^(#|\s)+/
  rescue ArgumentError
    true
  end

  def filename
    File.expand_path('../IpToCountry.csv', __FILE__)
  end

  def ip_integer(ip_string)
    ip = ip_string.split(".")
    ip[3].to_i + (ip[2].to_i * 256) + (ip[1].to_i * 256 * 256) + (ip[0].to_i * 256 * 256 * 256)
  end
end
