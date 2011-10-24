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

/**
 * Removes all cookies from the user request
 */
sub removeCookies {
	if(req.http.Cookie) {
		unset req.http.Cookie;
	}
}

/**
 * Sets the current backend to either the dynamic server or to the static
 * file server depending on the request. For now all requests for a binary
 * file or sent to the "staticfile" backend
 */
sub setCorrectBackend {
	set req.backend = default;

	if (req.url ~ "\.(jp[e]?g|png|gif|css|js)$") {
		set req.backend = staticfiles;
	}
}

/**
 * Normalizes the User-Agent header to its smallest version.
 * This avoids having multiple cache objects for the same browser
 * but with a slightly different User-Agent signature (i.e versio number)
 * and thus maximize your cache hit
 *
 * @link http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
 * @link http://www.useragentstring.com/pages/useragentstring.php
 */
sub normalizeUserAgent {
    if (req.http.User-Agent ~ "MSIE") {
        set req.http.User-Agent = "msie";
    } elseif(req.http.User-Agent ~ "Firefox") {
        set req.http.User-Agent = "firefox";
    } elseif(req.http.User-Agent ~ "Safari") {
        set req.http.User-Agent = "safari";
    } elseif(req.http.User-Agent ~ "Opera Mini/") {
        set req.http.User-Agent = "opera-mini";
    } elseif(req.http.User-Agent ~ "Opera Mobi/") {
        set req.http.User-Agent = "opera-mobile";
    } elseif(req.http.User-Agent ~ "Opera") {
        set req.http.User-Agent = "opera";
    } else {
        set req.http.User-Agent = "unknown";
    }
}
