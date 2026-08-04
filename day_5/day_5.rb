# frozen_string_literal: true

require_relative "../logger/logger"

require 'set'

module Day5
  extend self

  extend Logger

  VOWELS = Set.new(['a', 'e', 'i', 'o', 'u'])
  UNPERMITTED_SUBSTRINGS = Set.new(['ab', 'cd', 'pq', 'xy'])

  private_constant :VOWELS, :UNPERMITTED_SUBSTRINGS

  def part_one
    File.open(File.expand_path("puzzle.txt", __dir__)) do |file|
      file.each_line(chomp: true).lazy.each do |line|
        p line.count('a', 'e')
        next unless line.count('a', 'e', 'i', 'o', 'u') >= 3

        # ([a-z]) -> capture group 1, matches any single char and "remebers" it to be checked again on \1
        # next unless line.match?(/([a-z])\1/)

        # p line


      end
    end
  end
end

Day5.part_one
