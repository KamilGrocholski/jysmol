#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "jysmol-parser.h"

jysmol_value *parse_value(jysmol_parser *p);
jysmol_value *parse_string(jysmol_parser *p);
jysmol_value *parse_array(jysmol_parser *p);
jysmol_value *parse_number(jysmol_parser *p);
size_t get_integer_last_idx(jysmol_parser *p);

void skip_whitespace(jysmol_parser *p);
void eat(jysmol_parser *p, char ch);
void advance(jysmol_parser *p);

jysmol_value *jysmol_parse(jysmol_parser *p) {
  advance(p);
  return parse_value(p);
}

jysmol_value *parse_value(jysmol_parser *p) {
  skip_whitespace(p);
  printf("char: |%c|\n", p->ch);
  switch (p->ch) {
  case '"':
    return parse_string(p);
  case '[':
    return parse_array(p);
  default:
    if (isdigit(p->ch)) {
      return parse_number(p);
    } else if (p->ch == '-') {
      eat(p, '-');
      jysmol_value *value = parse_number(p);
      value->u.int_num = -value->u.int_num;
      return value;
    }
  }

  exit(EXIT_FAILURE);
}

jysmol_value *parse_array(jysmol_parser *p) {
  advance(p);
  skip_whitespace(p);
  jysmol_value *val = (jysmol_value *)malloc(sizeof(jysmol_value));
  vector *vec = vector_make();
  val->type = JYSMOL_ARRAY;

  while (p->ch != ']' && p->position < p->size) {
    jysmol_value *value = parse_value(p);
    vector_append(vec, &value);
    skip_whitespace(p);
    advance(p);
  }

  skip_whitespace(p);
  advance(p);
  val->u.array = vec;

  return val;
}

jysmol_value *parse_string(jysmol_parser *p) {
  advance(p);

  jysmol_value *val = (jysmol_value *)malloc(sizeof(jysmol_value));
  val->type = JYSMOL_STRING;

  size_t i = 0;
  size_t cap = 4;
  char *str = (char *)malloc(sizeof(char) * cap);

  while (p->ch != '"' && p->position < p->size) {
    if (i >= cap) {
      cap = cap * 2;
      str = realloc(str, sizeof(char) * cap);
    }
    memcpy(str, str, i);
    str[i] = p->ch;
    i++;
    advance(p);
  }

  val->u.string = str;
  printf("str: %s\n", val->u.string);
  advance(p);

  return val;
}

jysmol_value *parse_number(jysmol_parser *p) {
  size_t start = p->position;
  advance(p);
  jysmol_value *val = (jysmol_value *)malloc(sizeof(jysmol_value));
  size_t end = start;

  while (isdigit(p->ch) && p->position < p->size) {
    end++;
    advance(p);
  }

  if (p->ch == '.') {
    end++;
    while (isdigit(p->ch) && p->position < p->size) {
      end++;
      advance(p);
    }

    char lit[end - start];

    for (size_t i = start; i <= end; i++) {
      lit[i] = p->input[i];
    }

    val->type = JYSMOL_FLOAT;
    val->u.float_num = atof(lit);

    return val;
  }

  char lit[end - start];

  for (size_t i = start; i <= end; i++) {
    lit[i] = p->input[i];
  }

  val->type = JYSMOL_INT;
  val->u.int_num = atoi(lit);

  return val;
}

void skip_whitespace(jysmol_parser *p) {
  while (p->ch == ' ' || p->ch == '\n' || p->ch == '\r' || p->ch == '\t') {
    advance(p);
  }
}

void eat(jysmol_parser *p, char ch) {
  if (p->ch != ch) {
    exit(EXIT_FAILURE);
  }
  advance(p);
}

void advance(jysmol_parser *p) {
  p->position++;
  if (p->position < p->size) {
    p->ch = p->input[p->position];
  } else {
    p->ch = '\0';
  }
}
