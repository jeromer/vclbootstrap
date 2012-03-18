include "backends.vcl";
include "functions.vcl";
include "acl.vcl";

sub vcl_recv {
    call banIfAllowed;
    call pipeIfNonRFC2616;
    call passIfNonIdempotent;
    call passIfAuthorized;
    call removeCookies;
    call setCorrectBackend;
    call normalizeUserAgent;
    call normalizeAcceptEncoding;
}
