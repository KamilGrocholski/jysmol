#include "jysmol-parser.h"
#include "str.h"
#include <stdio.h>

int main() {
  jysmol_parser *p = (jysmol_parser *)malloc(sizeof(jysmol_parser));
  /* char *input = "1234.2"; */
  /* char *input = "[\"okej\",]"; */
  char *input = "\"okej\"";
  p->input = input;
  p->size = 6;
  /* p->size = 9; */
  /* p->size = 6; */
  p->ch = '\0';
  p->position = -1;

  jysmol_value *value = jysmol_parse(p);

  /* printf("%f", value->u.float_num); */
  printf("%s", value->u.string);
  /* printf("%s", ((jysmol_value *)(value->u.array->items[0]))->u.string); */
  /* printf("%lu", value->u.array->size); */
  /* char *item = "ok"; */
  /* vector_append(value->u.array, (void *)&item); */

  return 0;
}
