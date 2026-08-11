#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

# define MAX_LINE_LENGTH 1024
# define BOARD_SIZE 1000

# define INSTRUCTION_HEADER_LEN 10

typedef enum {
  ACTION_INVALID = -1,
  ACTION_TOGGLE,
  ACTION_ON,
  ACTION_OFF
} Action;

typedef enum {
  STATE_OFF = 0,
  STATE_ON = 1
} State;

typedef struct {
  Action action;
  unsigned int xs[2];
  unsigned int ys[2];
} Instruction;

typedef int Board[BOARD_SIZE][BOARD_SIZE];

Action parse_action(const char *raw);
Instruction parse(const char *line);
bool valid_action(Action a);
int count_lit_lights(Board board);
int perform(Action action, const int actual);
void execute(Instruction instruction, Board board);

int main(void) {
  FILE *file = fopen("./puzzle.txt", "r");
  if (file == NULL) exit(1);

  char line[MAX_LINE_LENGTH];
  Board board = {0};

  while (fgets(line, sizeof(line), file) != NULL) {
    Instruction instruction = parse(line);

    execute(instruction, board);
  }

  const int result = count_lit_lights(board);

  fclose(file);

  printf("result: %d\n", result);

  return 0;
}

Instruction parse(const char *line) {
  // The max head lenght is 9, so we need more one to store the null terminated char
  char raw_action[INSTRUCTION_HEADER_LEN];
  unsigned int x, y, x_end, y_end;

  int result = sscanf(line, "%9[a-z ] %u,%u through %u,%u", raw_action, &x, &y, &x_end, &y_end);

  if (result != 5) {
    perror("parse: Wrong assign number");
    exit(1);
  }

  Action action = parse_action(raw_action);

  if (!valid_action(action)) {
    perror("parse: Invalid action");
    exit(1);
  }

  Instruction instruction = {
    .action = action,
    .xs = {x, x_end},
    .ys = {y, y_end}
  };

  return instruction;
}

Action parse_action(const char *raw) {
  // TODO: implement trim function to enhance this comparsion wihtout the space in the end
  if (strcmp(raw, "toggle ") == 0) return ACTION_TOGGLE;

  if (strcmp(raw, "turn on ") == 0) return ACTION_ON;

  if (strcmp(raw, "turn off ") == 0) return ACTION_OFF;

  return ACTION_INVALID;
}

bool valid_action(Action a) { return a != ACTION_INVALID; }

void execute(Instruction instruction, Board board) {
  for (int x = instruction.xs[0]; x <= instruction.xs[1]; x++) {
    for (int y = instruction.ys[0]; y <= instruction.ys[1]; y++) {
      board[x][y] = perform(instruction.action, board[x][y]);
    }
  }
}

int perform(Action action, const int actual) {
  if (action == ACTION_TOGGLE) return actual == STATE_OFF ? STATE_ON : STATE_OFF;

  if (action == ACTION_ON) return STATE_ON;

  return STATE_OFF;
}

int count_lit_lights(Board board) {
  int count = 0;
  for (int x = 0; x < BOARD_SIZE; x++) {
    for (int y = 0; y < BOARD_SIZE; y++) {
      if (board[x][y] == STATE_ON) count++;
    }
  }

  return count;
}
