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
    directories, files = build_directories
    find_smallest_deletable_directory(files, directories)
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

  # The total disk space available to the filesystem is 70000000. To run the update, you need unused space of at least 30000000. You need to find a directory you can delete that will free up enough space to run the update.

  def find_smallest_deletable_directory(files, directories)
    total_size = files.map { |file| file.split(" ")[-1].to_i }.sum
    space_needed = total_size - 40000000
    directories.map do |directory|
      size = files.select { |file| file.start_with?(directory) }.map { |file| file.split(" ")[-1].to_i }.sum
      size
    end.select do |size|
      size > space_needed
    end.min
  end
end
