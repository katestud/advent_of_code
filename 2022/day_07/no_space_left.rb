class NoSpaceLeft

  CHANGE_DIR = /\$ cd (?<dir>.+)/
  FILE_MATCH = /(?<size>\d+) (?<name>.+)/

  def initialize(file_name = "input.txt")
    @file_name = file_name
  end

  def execute_one
    directories, files = build_directories
    find_sum_of_dirs_less_than_100k(files, directories)
  end

  def execute_two
    read_file.length
  end

  private

  def read_file
    File.readlines(@file_name, chomp: true)
  end

  def build_directories
    current_dir = ""
    directories = Set.new [""]
    files = Set.new
    listing = false
    read_file[1..-1].each do |line|
      next listing = true if line == "$ ls"
      if line.match?(CHANGE_DIR)
        listing = false
        new_dir = line.match(CHANGE_DIR)[:dir]
        if new_dir == ".."
          current_dir = current_dir.split("/")[0..-2].join("/")
        else
          current_dir += "/#{new_dir}"
        end
        directories.add(current_dir)
      elsif line.match?(/dir \w+/)
        next
      elsif line.match?(FILE_MATCH)
        filename = current_dir + "/" + line.match(FILE_MATCH)[:name] + " " + line.match(FILE_MATCH)[:size]
        files.add(filename)
      end
    end
    [directories, files]
  end

  def find_sum_of_dirs_less_than_100k(files, directories)
    directories.map do |directory|
      size = files.select { |file| file.start_with?(directory) }.map { |file| file.split(" ")[-1].to_i }.sum
      size
    end.select do |size|
      size <= 100000
    end.sum
  end
end
