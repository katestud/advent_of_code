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


#   Packets with type ID 0 are sum packets - their value is the sum of the values of their sub-packets. If they only have a single sub-packet, their value is the value of the sub-packet.
# Packets with type ID 1 are product packets - their value is the result of multiplying together the values of their sub-packets. If they only have a single sub-packet, their value is the value of the sub-packet.
# Packets with type ID 2 are minimum packets - their value is the minimum of the values of their sub-packets.
# Packets with type ID 3 are maximum packets - their value is the maximum of the values of their sub-packets.
# Packets with type ID 5 are greater than packets - their value is 1 if the value of the first sub-packet is greater than the value of the second sub-packet; otherwise, their value is 0. These packets always have exactly two sub-packets.
# Packets with type ID 6 are less than packets - their value is 1 if the value of the first sub-packet is less than the value of the second sub-packet; otherwise, their value is 0. These packets always have exactly two sub-packets.
# Packets with type ID 7 are equal to packets - their value is 1 if the value of the first sub-packet is equal to the value of the second sub-packet; otherwise, their value is 0. These packets always have exactly two sub-packets.

  Packet = Struct.new(:id, :type, :version, :remaining_chars, :remaining_packets, :total_characters, :value, :children, :parent) do

    def initialize(*)
      super
      self.remaining_chars ||= 0
      self.remaining_packets ||= 0
      self.children ||= []
    end
    def total_value
      total_vals = (children || []).compact.map(&:total_value).compact
      val = if type == "4"
        value
      elsif type == "0"
        total_vals.inject(:+)
      elsif type == "1"
        total_vals.inject(:*)
      elsif type == "2"
        total_vals.min
      elsif type == "3"
        total_vals.max
      elsif type == "5"
        total_vals[0] > total_vals[1] ? 1 : 0
      elsif type == "6"
        total_vals[0] < total_vals[1] ? 1 : 0
      elsif type == "7"
        total_vals[0] == total_vals[1] ? 1 : 0
      end
      puts children.map(&:id).inspect
      puts "id: #{id} parent: #{parent&.id} value: #{value} val: #{val} type: #{type}"
      val
    end
  end

  def initialize(file_name = "input.txt")
    @input = File.read(file_name, chomp: true).strip
    @test_input = "D2FE28"
    @test_input = "9C0141080250320F1802104A08"
    @version_sum = 0
    @all_packets = []
    @parent_stack = []
  end

  def execute_one
    scan_string(@input.chars.map { |c| MAPPING[c] }.reduce(:+))
    @version_sum
  end

  def execute_two
    scan_string(@input.chars.map { |c| MAPPING[c] }.reduce(:+))
    @all_packets.select {|p| p.parent.nil? }.map(&:total_value).inject(:+)
  end

  private

  def scan_string(values)
    scanner = StringScanner.new(values)
    iteration = 0
    until scanner.eos?
      packet = Packet.new(iteration)
      traverse_packet(packet, scanner)
      iteration += 1
    end
    scanner.rest
  end

  def traverse_packet(packet, scanner)
    version_binary = "0" + 3.times.map { scanner.getch }.join
    version = PacketDecoder::MAPPING.key(version_binary)
    packet.version = version

    @version_sum += version.to_i

    type_id_binary = "0" + 3.times.map { scanner.getch }.join
    type_id = PacketDecoder::MAPPING.key(type_id_binary)
    packet.type = type_id

    parent = @parent_stack.last

    if parent && parent.remaining_chars.to_i <= 0 && parent.remaining_packets.to_i <= 0
      @parent_stack.pop
      parent = @parent_stack.last
    end

    # puts "parent: #{parent&.id} id: #{packet.id} type: #{packet.type} version: #{packet.version} remaining: #{parent&.remaining_chars} #{parent&.remaining_packets}"
    # puts scanner.rest

    return if type_id.nil?
    return if type_id == "0" && scanner.rest.chars.all? { |c| c == "0" }
    @all_packets << packet

    if parent
      parent.children << packet
      packet.parent = parent
    end

    chars_to_remove = 6

    if type_id == "4"
      # It's a literal packet
      val = []
      loop do
        chars_to_remove += 5
        vals = 5.times.map { scanner.getch }
        val << vals[1..-1]
        break unless vals[0] == "1"
      end
      packet.value = val.join.to_i(2)
    else
      @parent_stack << packet
      # parent = packet
      length_type_id = scanner.getch
      if length_type_id == "1"
        chars_to_remove += 12
        remaining_packets = 11.times.map { scanner.getch }.join.to_i(2)
        packet.remaining_packets = remaining_packets
      else
        chars_to_remove += 16
        remaining_chars = 15.times.map { scanner.getch }.join.to_i(2)
        packet.remaining_chars = remaining_chars
        chars_to_remove += remaining_chars
      end
    end

    if parent
      parent.remaining_packets -= 1
      parent.remaining_chars -= chars_to_remove
      loop do
        if new_parent = parent.parent
          new_parent.remaining_chars -= chars_to_remove
          parent = new_parent
        else
          break
        end
      end
    end
  end

end

# I start with parent 0
# parent must be an operator packet
# parent will have either a number of characters to process, or a number of sub packets
# we enter the loop with parent 0
# we find a sub packet, 1, with 11 characters. that represents 6 starting charactes, and 5 remaining characters, we remove those from the "Remaining Characters" for parent 0
# then we find sub packet 2, with 16 characers. that represents 6 characters and 10 chracters, so we remove 6 and then 10 characters from the parent packet



# class Packet
#   ### Unused (for now)

#   def initialize(values)
#     @values = values
#   end

#   def literal_value?
#     type_id == "4"
#   end

#   def operator?
#     !literal_value?
#   end

#   def type_id
#     PacketDecoder::MAPPING.key("0" + @values[3..5])
#   end

#   def version
#     PacketDecoder::MAPPING.key("0" + @values[0..2])
#   end

#   def length_type_id
#     return unless operator?
#     @values[6]
#   end

#   def number_of_sub_packets
#     return unless operator?
#     return unless length_type_id == "1"
#     @values[7..17].to_i(2)
#   end

#   def length_of_sub_packets
#     return unless operator?
#     return unless length_type_id == "0"
#     @values[7..21].to_i(2)
#   end

#   def literal_number_binary
#     return unless literal_value?
#     val = []
#     @values[6..-1].chars.each_slice(5) do |slice|
#       val += slice[1..-1]
#       break unless slice[0] == "1"
#     end
#     val.join
#   end

#   def literal_number
#     return unless literal_value?
#     literal_number_binary.to_i(2)
#   end

# end
