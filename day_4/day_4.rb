require_relative "../logger/logger"

require 'digest'

module Day4
  extend self

  extend Logger

  def part_one
    input = File.open(File.expand_path("puzzle.txt", __dir__)).readline.strip
    # hash = Digest::MD5.file().hexdigest
    #File.expand_path("puzzle.txt", __dir__)

    ok = false
    counter = 0
    result = nil

    while !ok
      result = Digest::MD5.hexdigest input + counter.to_s

      ok = is_ok(result)
      counter += 1 unless ok
    end


    p "result #{result} :: #{counter}"
  end

  def part_two
  end

  def is_ok(result)
    p "Slice: #{result.slice(0, 6)}"
    result.slice(0, 5) == '00000'
  end
end

Day4.part_one
Day4.part_two
