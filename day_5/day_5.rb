# frozen_string_literal: true

require_relative "../logger/logger"

module Day5
  extend self

  extend Logger

  def part_one
    count = 0

    File.open(File.expand_path("puzzle.txt", __dir__)) do |file|
      file.each_line(chomp: true).each do |line|
        next unless enough_vowels?(line) and double_letter?(line)

        next if unpermitted_pair?(line)

        count += 1
      end
    end

    log(day: 5, part: 1, result: count)
  end

  def part_two
    count = 0

    File.open(File.expand_path("puzzle.txt", __dir__)) do |file|
      file.each_line(chomp: true).each do |line|
        count += 1 if pair?(line) && letter_repeats_with_one_between?(line)
      end
    end

    log(day: 5, part: 1, result: count)
  end

  private

  def enough_vowels?(line)
    line.count('aeiou') >= 3
  end

  def double_letter?(line)
    # ([a-z]) -> capture group 1, matches any single char and "remebers" it to be checked again on \1
    line.match?(/([a-z])\1/)
  end

  def unpermitted_pair?(line)
    line.match?(/ab|cd|pq|xy/)
  end

  def pair?(line)
    # ([a-z][a-z]) any pair | .* followed by anything one or multiple times | \1 that repeats
    line.match?(/([a-z][a-z]).*\1/)
  end

  def letter_repeats_with_one_between?(line)
    # ([a-z]). any char from 'a' to 'z' that has one char between the repetition (e.g asa or ghg)
    line.match?(/([a-z]).\1/)
  end
end

Day5.part_one
Day5.part_two
