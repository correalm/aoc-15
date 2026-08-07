# frozen_string_literal: true

require_relative "../logger/logger"
require_relative "../reader/reader"

module Day6
  extend self

  extend Logger
  extend Reader

  ACTIONS = {
    "toggle" => :toggle,
    "turn on" => :on,
    "turn off" => :off
  }

  Instruction = Data.define(:action, :xs, :ys)

  private_constant :ACTIONS, :Instruction

  def part_one
    transformers = {
      toggle: ->(state) { !state },
      on: ->(state) { true },
      off: ->(state) { false },
    }

    board = init_board(false)

    lines.each do |line|
      instruction = parse(line)
      action = transformers[instruction.action]

      for ix in instruction.xs
        for iy in instruction.ys
          board[ix][iy] = action.call(board[ix][iy])
        end
      end
    end

    log(day: 6, part: 1, result: board.flatten.select{|l| l}.count)
  end

  def part_two
    transformers = {
      toggle: ->(state) { state + 2 },
      on: ->(state) { state + 1 },
      off: ->(state) { (state - 1 >= 0) ? (state - 1) : 0 },
    }

    board = init_board(0)

    lines.each do |line|
      instruction = parse(line)
      action = transformers[instruction.action]

      for ix in instruction.xs
        for iy in instruction.ys
          board[ix][iy] = action.call(board[ix][iy])
        end
      end
    end

    log(day: 6, part: 1, result: board.flatten.select{|l| l}.sum)
  end

  private

  def lines
    read_lines(filename: 'puzzle.txt', dir: __dir__)
  end

  def parse(line)
    *action_words, start_coords, _, end_coords = line.split(' ')

    action = ACTIONS.fetch(action_words.join(' ')) { raise  "parse :: invalid instrucion: #{line}" }

    x, y = parse_coords(start_coords)
    end_x, end_y = parse_coords(end_coords)

    Instruction.new(action: action,
                    xs: x..end_x,
                    ys: y..end_y)
  end

  def parse_coords(raw)
    x, y = raw.split(',')

    [Integer(x), Integer(y)]
  end

  def init_board(state)
    board = []

    #            board
    #     y1    y2      y3
    # x1 [[false, false, false ...]
    # x2 [[false, false, false ...]]
    #              ...
    for x in 0..999
      board[x] = []

      for y in 0..999
        board[x] << state
      end
    end

    board
  end
end

Day6.part_one
Day6.part_two
