#include <stdbool.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

#include "str.h"

size_t str_pop_first_split(str *src, str split_by) {
  size_t l = 0;

  while (l < src->size) {
    if (src->data[l] == split_by.data[l]) {
      return l;
    }
    l++;
  }

  return 0;
}

str str_sub(str src, size_t start, size_t end) {
  char out[end - start + 1];
  size_t i = start;

  while (i < end) {
    out[i] = src.data[i];
  }

  out[i] = '\0';

  return (str){.data = out, .size = end - start + 1};
}

bool str_contains(str haystack, str needle) {
  return NULL != strstr(haystack.data, needle.data);
}

bool str_valid(str s) { return strlen(s.data) == s.size; }

bool str_match(str a, str b) {
  if (a.size != b.size)
    return false;

  for (size_t i = 0; i < a.size; i++) {
    if (a.data[i] != b.data[i])
      return false;
  }

  return true;
}

str_buf *str_buf_make(size_t capacity) {
  str_buf *b = malloc(sizeof(str_buf));
  b->data = malloc(sizeof(capacity));
  b->size = 0;
  b->capacity = capacity;

  return b;
}

void str_buf_append(str_buf *buf, str *to_append) {
  size_t new_capacity = buf->capacity == 0
                            ? to_append->size
                            : buf->capacity * 2 + to_append->size;
  buf->data = (char *)realloc(buf->data, new_capacity);
  memcpy(buf->data + buf->size, to_append->data, to_append->size);
  buf->capacity = new_capacity;
  buf->size += to_append->size;
}

void str_buf_insert(str_buf *buf, str to_insert, size_t start) {
  if (start > buf->size - 1 || start < 0) {
    return;
  }

  size_t new_capacity =
      buf->capacity == 0 ? to_insert.size : buf->capacity * 2 + to_insert.size;
  buf->data = (char *)realloc(buf->data, new_capacity);
  memmove(buf->data + start, to_insert.data, to_insert.size);
  buf->capacity = new_capacity;
  buf->size += to_insert.size;
}

void str_buf_remove(str_buf *buf, size_t p_start, size_t p_end) {
  if (buf->size == 0 || p_start >= buf->size || p_end >= buf->size ||
      p_start > p_end) {
    return;
  }

  size_t start = (p_start < buf->size) ? p_start : buf->size - 1;
  size_t end = (p_end < buf->size) ? p_end : buf->size - 1;

  size_t shift_count = buf->size - end;

  memcpy(buf->data + start, buf->data + end + 1, shift_count);
  buf->size -= (end - start + 1);
}

void str_buf_free(str_buf *buf) {
  free(buf->data);
  free(buf);
}

str str_buf_str(str_buf *buf) {
  return (str){.data = buf->data, .size = buf->size};
}
