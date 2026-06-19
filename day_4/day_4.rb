require_relative "../logger/logger"

require 'digest'

module Day4
  extend self

  extend Logger

  HEAD_MATCHER = '0'

  def part_one
    input = read_input

    salt = find_salt_for(input: input, leading_zeroes: 5)

    log(day: 4, part: 1, result: salt)
  end

  def part_two
    input = read_input

    salt = find_salt_for(input: input, leading_zeroes: 6)

    log(day: 4, part: 2, result: salt)
  end

  private

  def find_salt_for(input:, leading_zeroes:)
    ok = false
    salt = 0

    while !ok
      ok = check_head_of(hash: hash(input, salt),
                         leading_zeroes: leading_zeroes)

      salt += 1 unless ok
    end

    salt
  end

  def read_input
    File.open(File.expand_path("puzzle.txt", __dir__)).readline.strip
  end

  def check_head_of(hash:, leading_zeroes:)
    expected_header = HEAD_MATCHER * leading_zeroes

    hash.start_with? expected_header
  end

  def hash(input, salt)
    Digest::MD5.hexdigest(input + salt.to_s)
  end
end

Day4.part_one
Day4.part_two
