PATH = Rails.root.join('public', 'permutation_test')

def parse_options
  options = ActiveSupport::HashWithIndifferentAccess.new
  separator_index = ARGV.index("--")
  if separator_index
    option_array = ARGV.slice(separator_index + 1 , ARGV.length)
    option_pairs = option_array.map { |pair| pair.split("=") }
    option_pairs.each { |opt| options[opt[0]] = opt[1] || true }
  end
  options
end

namespace :permutations do
    desc "import_files"
    task :import_files do

      Dir.children(PATH).each do |filename|

        file_path = "#{PATH}/#{filename}"
        puts filename

        File.foreach(file_path).with_index do |line, line_num|
           # 1X PERMUTATIONS LOGIC
           permutations = line.strip.chars.permutation.map &:join
           puts permutations.sort.join(",")
        end
      end
    end

    desc "read_input"
    task :read_input do

      options = parse_options
  
      filename = options[:file]

      file_path = "#{PATH}/#{filename}"
      puts file_path

      File.readlines(file_path).each_with_index do |line, line_num|
        # 2X PERMUTATIONS LOGIC
        permutations = line.strip.chars.permutation.map &:join
        puts permutations.sort.join(",")
      end
    end

    desc "generate_random"
    task :generate_random do
      # good through 9 characters before timing out
      desired_length = 9
      tests = 5

      tests.times do
        test = SecureRandom.alphanumeric(desired_length)
        puts "========================================"
        puts "Input: #{test}"
        puts "========================================"
        # 3X PERMUTATIONS LOGIC
        permutations = test.strip.chars.permutation.map &:join
        puts permutations.sort.join(", ")
        puts "\n"
      end
    end

  end

