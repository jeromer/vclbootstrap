/**
 * This file contains misc functions that are useful when
 * working with a VCL file.
 * These functions may not apply to your context, feel free to
 * adapt these to your liking
 */

/**
 * Returns pipe if the request method is not RFC 2616 compliant
 * @link http://www.w3.org/Protocols/rfc2616/rfc2616-sec5.html#sec5.1.1
 */
sub pipeIfNonRFC2616 {
    if (req.request != "GET"     &&
        req.request != "HEAD"    &&
        req.request != "PUT"     &&
        req.request != "POST"    &&
        req.request != "TRACE"   &&
        req.request != "OPTIONS" &&
        req.request != "DELETE") {
		return (pipe);
	}
}

/**
 * Returns "pass" if the request method is not GET or HEAD.
 * POST request will be transfered to the origin server(s)
 *
 * @link https://secure.wikimedia.org/wikipedia/en/wiki/Idempotence
 */
sub passIfNonIdempotent {
	if (req.request != "GET" && req.request != "HEAD") {
		return (pass);
	}
}

/**
 * Returns "pass" if some authorization (i.e .htaccess) is required
 * for the current page
 */
sub passIfAuthorized {
	if (req.http.Authorization) {
		return (pass);
	}
}
