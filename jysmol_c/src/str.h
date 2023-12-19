#include <stddef.h>

typedef struct str {
  size_t size;
  char *data;
} str;

typedef struct str_buf {
  size_t size;
  size_t capacity;
  char *data;
} str_buf;

str_buf *str_buf_make(size_t capacity);
void str_buf_append(str_buf *buf, str *to_append);
void str_buf_insert(str_buf *, str, size_t);
void str_buf_remove(str_buf *, size_t, size_t);
void str_buf_free(str_buf *);
size_t str_pop_first_split(str *src, str split_by);
str str_buf_str(str_buf *);

bool str_match(str, str);
bool str_valid(str);
bool str_contains(str, str);
str str_sub(str src, size_t start, size_t end);
