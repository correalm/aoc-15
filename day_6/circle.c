#include <stdio.h>
#include <math.h>
#include <stdbool.h>

typedef struct {
  int x;
  int y;
} Point;

Point find_center(int size) {
  // this have the assumption that the start point is 0,0
  float center_x = size / 2;
  float center_y = size / 2;

  Point result = { .x = (int)roundf(center_x), .y = (int)roundf(center_y) };

  return result;
}

bool is_point_on_circle(int dx, int dy, int r) {
  return (pow(dx, 2) + pow(dy,2)) < pow(r, 2);
}

bool is_outer_circle(Point p, Point center, int radius) {
  int dx = p.x - center.x;
  int dy = p.y - center.y;

  return is_point_on_circle(dx, dy, radius);
}

bool is_inner_circle(Point p, Point center, int radius) {
  int dx = p.x - center.x;
  int dy = p.y - center.y;

  // The inner circle will have a radius of 1/3 of the outer circle
  return is_point_on_circle(dx, dy, radius / 3);
}

int find_size(int radius) {
  // +1 to get a new line and enough space
  return 2 * radius + 1;
}

void circle() {
  int radius = 15;
  int size = find_size(radius);
  Point center = find_center(size);

  for (int x = 0; x < size; x++) {
    for (int y = 0; y < size; y++) {
      Point point = { .x = x, .y = y };

      if (is_inner_circle(point, center, radius)) { printf(" "); }
      else if (is_outer_circle(point, center, radius)) { printf("@"); }
      else printf(" ");
    }

    printf("\n");
  }
}

int main(void) {
  circle();

  return 0;
}
