/**
 * This is the default backend used for dynamic requests
 */
backend default {
    .host = "192.168.1.2";
    .port = "8000";
}

/**
 * This is a backend for static files
 */
backend staticfiles {
    .host = "192.168.1.2";
    .port = "80";
}
