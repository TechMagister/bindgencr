
#ifndef HTTP_HTTP_H
#define HTTP_HTTP_H

#if defined(__cplusplus)
extern "C" {
#endif

/**
 * Callbacks for handling response data.
 *  realloc_scratch - reallocate memory, cannot fail. There will only
 *                    be one scratch buffer. Implemnentation may take
 *                    advantage of this fact.
 *  body - handle HTTP response body data
 *  header - handle an HTTP header key/value pair
 *  code - handle the HTTP status code for the response
 */
struct http_funcs {
    void* (*realloc_scratch)(void* opaque, void* ptr, int size);
    void (*body)(void* opaque, const char* data, int size);
    void (*header)(void* opaque, const char* key, int nkey, const char* value, int nvalue);
    void (*code)(void* opqaue, int code);
};

struct http_roundtripper {
    struct http_funcs funcs;
    void *opaque;
    char *scratch;
    int code;
    int parsestate;
    int contentlength;
    int state;
    int nscratch;
    int nkey;
    int nvalue;
    int chunked;
};

/**
 * Initializes a rountripper with the specified response functions. This must
 * be called before the rt object is used.
 */
void http_init(struct http_roundtripper* rt, struct http_funcs, void* opaque);

/**
 * Frees any scratch memory allocated during parsing.
 */
void http_free(struct http_roundtripper* rt);

/**
 * Parses a block of HTTP response data. Returns zero if the parser reached the
 * end of the response, or an error was encountered. Use http_iserror to check
 * for the presence of an error. Returns non-zero if more data is required for
 * the response.
 */
int http_data(struct http_roundtripper* rt, const char* data, int size, int* read);

/**
 * Returns non-zero if a completed parser encounted an error. If http_data did
 * not return non-zero, the results of this function are undefined.
 */
int http_iserror(struct http_roundtripper* rt);

#if defined(__cplusplus)
}
#endif

#endif