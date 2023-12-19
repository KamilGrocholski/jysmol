#ifndef _HASHTABLE_H
#define _HASHTABLE_H

#include <stddef.h>

#include "vector.h"

typedef struct ht ht;

typedef struct key_value_pair {
  char *key;
  void *value;
} key_value_pair;

typedef struct ht {
  vector pairs;
} ht;

ht ht_make();
void ht_set(ht *ht, char *key, void *value);
void *ht_get(ht *ht, char *key);
void ht_remove();

#endif // !_HASHTABLE_H
