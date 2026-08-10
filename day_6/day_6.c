#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

# define MAX_LINE_LENGTH 1024

typedef enum {
  ACTION_INVALID = -1,
  ACTION_TOGGLE,
  ACTION_ON,
  ACTION_OFF
} Action;

typedef struct {
  Action action;
  unsigned int xs[2];
  unsigned int ys[2];
} Instruction;

Instruction parse(const char *line);
Action parse_action(const char *raw);
bool valid_action(Action a);

int main(void) {
  FILE *file = fopen("./puzzle.txt", "r");
  if (file == NULL) exit(1);

  char line[MAX_LINE_LENGTH];

  while (fgets(line, sizeof(line), file) != NULL) {
    parse(line);
  }

  fclose(file);

  return 0;
}

Instruction parse(const char *line) {
  // The max head lenght is 9, so we need more one to store the null terminated char
  char raw_action[10];
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
