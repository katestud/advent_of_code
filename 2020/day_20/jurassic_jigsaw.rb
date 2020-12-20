require "active_support/core_ext/hash/except"

class Tile

  attr_reader :id, :rows

  def initialize(str)
    lines = str.split("\n")
    @id = lines.first.match(/\d+/)[0]
    @rows = lines[1..-1]
  end

  def borders
    existing_borders = [
      rows[0],
      rows[-1],
      rows.map {|str| str[0] }.join,
      rows.map {|str| str[-1] }.join,
    ]

    borders = existing_borders + existing_borders.map(&:reverse)
  end

end

class Image

  attr_reader :tiles

  def initialize(tiles)
    @tiles = Hash[tiles.map { |t| [t.id, t] } ]
  end

  def other_tile_borders(tile_id)
    tiles.except(tile_id).values.map(&:borders).flatten
  end

end

input = File.read("input.txt").split("\n\n")
tiles = input.map { |tile| Tile.new(tile) }

image = Image.new(tiles)

corners = []
tiles.each do |tile|
  # Corners will be the items that have the most unmatched borders
  if (tile.borders - image.other_tile_borders(tile.id)).count == 4
    corners << tile.id
  end
end

puts "Product of all corners is:"
puts corners.map(&:to_i).inject(&:*)
