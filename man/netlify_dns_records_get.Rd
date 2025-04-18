% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/yay.gen.R
\name{netlify_dns_records_get}
\alias{netlify_dns_records_get}
\title{Get Netlify DNS records}
\usage{
netlify_dns_records_get(
  domain,
  token = funky::config_val("netlify_token"),
  max_tries = 3L
)
}
\arguments{
\item{domain}{Domain name to retrieve DNS records for. This is translated into the corresponding Netlify DNS Zone. A character scalar.}

\item{token}{\href{https://docs.netlify.com/api/get-started/#authentication}{Netlify personal access token} used for authentication. A character scalar.}

\item{max_tries}{Maximum number of request attempts in case of an HTTP error. An integerish scalar. Retries are performed using exponential backoff and jitter, see \code{\link[httr2:req_retry]{httr2::req_retry()}} for details.}
}
\value{
A \link[tibble:tbl_df-class]{tibble} with the columns \code{type}, \code{hostname}, \code{value}, \code{ttl}, \code{priority}, \code{weight}, \code{port}, \code{flag}, \code{tag}, \code{id}, \code{dns_zone_id}, \code{site_id}, and \code{managed}.
}
\description{
Retrieves DNS records from Netlify for the specified \code{domain} using the
\href{https://open-api.netlify.com/#tag/dnsZone/operation/getDnsRecords}{\code{getDnsRecords}} endpoint of \href{https://docs.netlify.com/api/get-started/}{Netlify's RESTful API}.
}
\examples{
\dontrun{
yay::netlify_dns_records_get(domain = "my.site")

# to write "portable" record keys to a TOML file `dns_records.toml` with a `records` table
# NOTE that the CLI tool `jsontoml` is required for this: https://github.com/pelletier/go-toml/
yay::netlify_dns_records_get(domain = "my.site") |>
  # remove records which can't be handled via API
  dplyr::filter(!managed) |>
  # remove Netlify-specific cols
  dplyr::select(any_of(colnames(yay:::ptype_dns_records))) |>
  # convert to target list structure
  list(records = _) |>
  # convert to JSON
  jsonlite::toJSON(auto_unbox = TRUE,
                   pretty = TRUE) |>
  # convert JSON to TOML via external CLI
  system2(input = _,
          stdout = TRUE,
          command = "jsontoml") |>
  # remove leading newline
  _[-1L] |>
  # write TOML to file
  brio::write_lines(path = "dns_records.toml")}
}
\seealso{
Other Netlify functions:
\code{\link{netlify_dns_records_delete}()},
\code{\link{netlify_dns_records_set}()}
}
\concept{netlify}
