% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/yay.gen.R
\name{netlify_dns_records_delete}
\alias{netlify_dns_records_delete}
\title{Delete Netlify DNS records}
\usage{
netlify_dns_records_delete(
  records,
  domain,
  token = pal::pkg_config_val("netlify_token"),
  max_tries = 3L
)
}
\arguments{
\item{records}{DNS records to delete. A character vector of record identifiers or a dataframe/tibble with an \code{id} column. Further columns are silently
ignored.}

\item{domain}{Domain name to delete DNS records for. This is translated into the corresponding Netlify DNS Zone. A character scalar.}

\item{token}{\href{https://docs.netlify.com/api/get-started/#authentication}{Netlify personal access token} used for authentication. A character scalar.}

\item{max_tries}{Maximum number of attempts to retry in case of an HTTP error. An integerish scalar.}
}
\value{
A character vector of deleted record identifiers, invisibly.
}
\description{
Deletes DNS records on Netlify for the specified \code{domain} using the \href{https://open-api.netlify.com/#tag/dnsZone/operation/deleteDnsRecord}{\code{deleteDnsRecord}}
endpoint of \href{https://docs.netlify.com/api/get-started/}{Netlify's RESTful API}. DNS \code{records} must be provided as either a character vector of DNS record
identifiers or a dataframe/tibble with an \code{id} column. Further columns are silently ignored.
}
\details{
Supported are the DNS record types \code{A}, \code{AAAA}, \code{ALIAS}, \code{CAA}, \code{CNAME}, \code{MX}, \code{NS}, \code{SPF}, \code{SRV} and \code{TXT}. Netlify's own custom record
types \code{NETLIFY} and \code{NETLIFY6} cannot be altered via the API and must be configured via \href{https://app.netlify.com/}{Netlify's web interface}.
}
\examples{
\dontrun{
yay::netlify_dns_records_delete(domain = "my.site",
                                records = "xyz123")

# The output of `netlify_dns_records_get()` can directly be fed. To delete all (!) records:
yay::netlify_dns_records_get(domain = "my.site") |>
  dplyr::filter(!managed) |>
  yay::netlify_dns_records_delete(domain = "my.site")}
}
\seealso{
Other Netlify functions:
\code{\link{netlify_dns_records_get}()},
\code{\link{netlify_dns_records_set}()}
}
\concept{netlify}
