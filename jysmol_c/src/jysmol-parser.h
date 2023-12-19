#ifndef _JYSMOL_PARSER_H
#define _JYSMOL_PARSER_H

#include <stdbool.h>
#include <stddef.h>

#include "vector.h"

typedef struct jysmol_parser {
  int position;
  char ch;
  char *input;
  size_t size;
} jysmol_parser;

typedef enum jysmol_v_type {
  JYSMOL_ARRAY,
  JYSMOL_INT,
  JYSMOL_FLOAT,
  JYSMOL_STRING
} jysmol_v_type;

typedef struct jysmol_value {
  jysmol_v_type type;
  union {
    vector *array;
    int int_num;
    float float_num;
    char *string;
  } u;
} jysmol_value;

jysmol_value *jysmol_parse(jysmol_parser *parser);

#endif // !_JYSMOL_PARSER_H
