#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "vector.h"

#define DEBUG_ON

vector *vector_make() {
  vector *v = (vector *)malloc(sizeof(vector));
  v->size = 0;
  v->capacity = VECTOR_INITIAL_CAPACITY;
  v->items = malloc(sizeof(void *) * VECTOR_INITIAL_CAPACITY);

  return v;
};

void vector_resize(vector *v, size_t new_capacity) {
#ifdef DEBUG_ON
  printf("vector_resize: %lu to %lu\n", v->capacity, new_capacity);
#endif

  void **items = (void **)realloc(v->items, sizeof(void *) * new_capacity);
  if (items) {
    v->items = items;
    v->capacity = new_capacity;
  }
}

void vector_append(vector *v, void *item) {
  if (v->capacity == v->size) {
    vector_resize(v, v->capacity * 2);
  }
  v->items[v->size] = item;
  v->size++;
}

void *vector_get(vector *v, size_t idx) {
  if (idx >= 0 && idx < v->size)
    return v->items[idx];
  return NULL;
}

void vector_set(vector *v, size_t idx, void *item) {
  if (!v)
    return;

  if ((idx >= 0) && (idx < v->size)) {
    v->items[idx] = item;
  }
}

void vector_free(vector *v) { free(v->items); }
