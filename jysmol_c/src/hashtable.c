#include "hashtable.h"

ht ht_make() { return (ht){}; }

void ht_set(ht *ht, char *key, void *value) {
  key_value_pair pair = (key_value_pair){};
}

void *ht_get(ht *ht, char *key);

void ht_remove();

size_t ht_size(ht *ht);
