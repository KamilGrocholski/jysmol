#ifndef _VECTOR_H
#define _VECTOR_H

#include <stddef.h>
#include <stdlib.h>

#define VECTOR_INITIAL_CAPACITY 8

typedef struct vector {
  size_t capacity;
  size_t size;
  void **items;
} vector;

vector *vector_make();
void *vector_get(vector *v, size_t idx);
void vector_set(vector *v, size_t idx, void *item);
void vector_resize(vector *v, size_t new_capacity);
void vector_append(vector *v, void *item);
void vector_free(vector *v);

#endif // !_VECTOR_H
