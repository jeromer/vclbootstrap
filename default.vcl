include "backends.vcl";
include "functions.vcl";

sub vcl_recv {
    call pipeIfNonRFC2616;
    call passIfNonIdempotent;
    call passIfAuthorized;
    call removeCookies;
    call setCorrectBackend;
    call normalizeUserAgent;
    call normalizeAcceptEncoding;
}
