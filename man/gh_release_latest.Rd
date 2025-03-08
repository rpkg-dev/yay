% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/yay.gen.R
\name{gh_release_latest}
\alias{gh_release_latest}
\title{Get latest release from GitHub repository}
\usage{
gh_release_latest(owner, name)
}
\arguments{
\item{owner}{GitHub repository owner (GitHub user or organisation). A character scalar.}

\item{name}{Repository name. A character scalar.}
}
\value{
A \link[tibble:tbl_df-class]{tibble} with the columns \code{id}, \code{version_nr}, \code{is_pre_release}, and \code{is_draft}.
}
\description{
Uses \code{\link[gh:gh]{gh::gh()}} to fetch the latest \href{https://docs.github.com/repositories/releasing-projects-on-github}{GitHub release} of the specified GitHub repository
via \href{https://docs.github.com/en/rest/releases/releases#get-the-latest-release}{GitHub's RESTful API} and returns its metadata as a single-row
\link[tibble:tbl_df-class]{tibble} containing the columns \code{id}, \code{version_nr}, \code{is_pre_release} and \code{is_draft}.
}
\examples{
yay::gh_release_latest(owner = "jgm",
                       name = "pandoc")
}
\seealso{
Other GitHub functions:
\code{\link{gh_dir_ls}()},
\code{\link{gh_releases}()},
\code{\link{gh_text_file}()},
\code{\link{gh_text_files}()}
}
\concept{gh}
