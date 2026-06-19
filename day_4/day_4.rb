require_relative "../logger/logger"

require 'digest'

module Day4
  extend self

  extend Logger

  HEAD_MATCHER = '00000'

  def part_one
    input = File.open(File.expand_path("puzzle.txt", __dir__)).readline.strip

    ok = false
    salt = 0
    result = nil

    while !ok
      result = Digest::MD5.hexdigest input + salt.to_s

      ok = check_head_of result
      salt += 1 unless ok
    end

    log(day: 4, part: 1, result: salt)
  end

  def part_two
  end

  def check_head_of(result)
    result.slice(0, 5) == HEAD_MATCHER
  end
end

Day4.part_one
Day4.part_two
