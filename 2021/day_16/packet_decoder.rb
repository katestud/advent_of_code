require "strscan"

class PacketDecoder

  MAPPING = {
    "0" => "0000",
    "1" => "0001",
    "2" => "0010",
    "3" => "0011",
    "4" => "0100",
    "5" => "0101",
    "6" => "0110",
    "7" => "0111",
    "8" => "1000",
    "9" => "1001",
    "A" => "1010",
    "B" => "1011",
    "C" => "1100",
    "D" => "1101",
    "E" => "1110",
    "F" => "1111"
  }

  def initialize(file_name = "input.txt")
    @input = File.read(file_name, chomp: true).strip
    # @test_input = "D2FE28"
    # @test_input = "38006F45291200"
    @version_sum = 0
  end

  def execute_one
    scan_string(@input.chars.map { |c| MAPPING[c] }.reduce(:+))
    @version_sum
  end

  def execute_two
    0
  end

  private

  def scan_string(values)
    scanner = StringScanner.new(values)
    until scanner.eos?
      version_binary = "0" + 3.times.map { scanner.getch }.join
      version = PacketDecoder::MAPPING.key(version_binary)
      @version_sum += version.to_i
      type_id_binary = "0" + 3.times.map { scanner.getch }.join
      type_id = PacketDecoder::MAPPING.key(type_id_binary)
      traverse_packet(scanner, type_id)
    end
    scanner.rest
  end

  def traverse_packet(scanner, type_id)
    if type_id == "4"
      # It's a literal packet
      loop do
        vals = 5.times.map { scanner.getch }
        break unless vals[0] == "1"
      end
    else
      length_type_id = scanner.getch
      if length_type_id == "1"
        11.times.map { scanner.getch }
      else
        15.times.map { scanner.getch }
      end
    end
  end

end


class Packet
  ### Unused (for now)

  def initialize(values)
    @values = values
  end

  def literal_value?
    type_id == "4"
  end

  def operator?
    !literal_value?
  end

  def type_id
    PacketDecoder::MAPPING.key("0" + @values[3..5])
  end

  def version
    PacketDecoder::MAPPING.key("0" + @values[0..2])
  end

  def length_type_id
    return unless operator?
    @values[6]
  end

  def number_of_sub_packets
    return unless operator?
    return unless length_type_id == "1"
    @values[7..17].to_i(2)
  end

  def length_of_sub_packets
    return unless operator?
    return unless length_type_id == "0"
    @values[7..21].to_i(2)
  end

  def literal_number_binary
    return unless literal_value?
    val = []
    @values[6..-1].chars.each_slice(5) do |slice|
      val += slice[1..-1]
      break unless slice[0] == "1"
    end
    val.join
  end

  def literal_number
    return unless literal_value?
    literal_number_binary.to_i(2)
  end

end
