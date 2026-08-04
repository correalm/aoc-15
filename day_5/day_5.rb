# frozen_string_literal: true

require_relative "../logger/logger"

require 'set'

module Day5
  extend self

  extend Logger

  def part_one
    count = 0

    File.open(File.expand_path("puzzle.txt", __dir__)) do |file|
      file.each_line(chomp: true).each do |line|
        next unless line.count('aeiou') >= 3

        # ([a-z]) -> capture group 1, matches any single char and "remebers" it to be checked again on \1
        next unless line.match?(/([a-z])\1/)

        next if line.match?(/ab|cd|pq|xy/)

        count += 1
      end
    end

    log(day: 5, part: 1, result: count)
  end
end

Day5.part_one
