# frozen_string_literal: true

require_relative "../logger/logger"
require_relative "../reader/reader"

require 'set'

module Day6
  extend self

  extend Logger
  extend Reader

  Point = Struct.new(:x, :y, :state)

  Actions = { on: 'turn on', off: 'turn off', toggle: 'toggle' }
  State = { on: true, off: false }

  def part_one
    board = init_board

    lines.lazy.each do |line|
      current_action = Actions[:on]

      if line.start_with?('toggle')
        line.delete_prefix!('toggle')
        current_action = Actions[:toggle]
      elsif line.start_with?('turn on')
        current_action = Actions[:on]
        line.delete_prefix!('turn on')
      else
        current_action = Actions[:off]
        line.delete_prefix!('turn off')
      end

      initial, _,final = line.strip.chomp.split(' ')

      x, y = initial.split(',')
      end_x, end_y = final.split(',')

      for ix in x.to_i..end_x.to_i
        for iy in y.to_i..end_y.to_i
          current_state = board[ix][iy]

          if current_action == Actions[:toggle]
            board[ix][iy] = !current_state
          else
            board[ix][iy] = current_action == Actions[:on]
          end
        end
      end
    end

    p board.flatten.select{|l| l}.count
  end

  def part_2
  end

  private

  def lines
    read_lines(filename: 'puzzle.txt', dir: __dir__)
  end

  def init_board
    board = []

    #            board
    #     y1    y2      y3
    # x1 [[false, false, false ...]
    # x2 [[false, false, false ...]]
    #              ...
    for x in 0..999
      board[x] = []

      for y in 0..999
        board[x] << State[:off]
      end
    end

    board
  end
end

Day6.part_one
