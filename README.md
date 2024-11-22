# yay

<a href="https://cran.r-project.org/package=yay" class="pkgdown-release"><img src="https://r-pkg.org/badges/version/yay" alt="CRAN Status" /></a>

A delightful mix of convenience functions designed to put a smile on your face during typical R workflows.

This is arguably a [*low-cohesion*](https://en.wikipedia.org/wiki/Cohesion_(computer_science)) package.

## Documentation

[![Netlify Status](https://api.netlify.com/api/v1/badges/d6148c7f-0c73-4b79-9c8d-54a5a25e98f9/deploy-status)](https://app.netlify.com/sites/yay-rpkg-dev/deploys)

The documentation of this package is found [here](https://yay.rpkg.dev).

## Installation

To install the latest development version of yay, run the following in R:

``` r
if (!("remotes" %in% rownames(installed.packages()))) {
  install.packages(pkgs = "remotes",
                   repos = "https://cloud.r-project.org/")
}

remotes::install_gitlab(repo = "rpkg.dev/yay")
```

## Package configuration

Some of yay’s functionality is controlled via package-specific global configuration which can either be set via [R options](https://rdrr.io/r/base/options.html) or [environment variables](https://en.wikipedia.org/wiki/Environment_variable) (the former take precedence). This configuration includes:

::: table-wide
| **Description**                                                                                                                                                                                        | **R option**                 | **Environment variable**       | **Default value**                |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------|:-------------------------------|:---------------------------------|
| Base URL of the GitLab v4 RESTful API server to be accessed via the [`gl_*()` functions](https://yay.rpkg.dev/reference/index.html#gitlabr).                                                           | `yay.gitlab_base_url`        | `R_YAY_GITLAB_BASE_URL`        | `"https://gitlab.com/api/v4"`    |
| [GitLab access token](https://docs.gitlab.com/ee/api/rest/authentication.html) used for authentication in the [`gl_*()` functions](https://yay.rpkg.dev/reference/index.html#gitlabr).                 | `yay.gitlab_token`           | `R_YAY_GITLAB_TOKEN`           | `Sys.getenv("GITLAB_COM_TOKEN")` |
| [Netlify personal access token](https://docs.netlify.com/api/get-started/#authentication) used for authentication in the [`netlify_*()` functions](https://yay.rpkg.dev/reference/index.html#netlify). | `yay.netlify_token`          | `R_YAY_NETLIFY_TOKEN`          |                                  |
| [Porkbun API key](https://porkbun.com/api/json/v3/documentation#Authentication) used for authentication in the [`porkbun_*()` functions](https://yay.rpkg.dev/reference/index.html#porkbun).           | `yay.porkbun_api_key`        | `R_YAY_PORKBUN_API_KEY`        |                                  |
| [Porkbun secret API key](https://porkbun.com/api/json/v3/documentation#Authentication) used for authentication in the [`porkbun_*()` functions](https://yay.rpkg.dev/reference/index.html#porkbun).    | `yay.porkbun_secret_api_key` | `R_YAY_PORKBUN_SECRET_API_KEY` |                                  |
:::

## Development

### R Markdown format

This package’s source code is written in the [R Markdown](https://rmarkdown.rstudio.com/) file format to facilitate practices commonly referred to as [*literate programming*](https://en.wikipedia.org/wiki/Literate_programming). It allows the actual code to be freely mixed with explanatory and supplementary information in expressive Markdown format instead of having to rely on [`#` comments](https://cran.r-project.org/doc/manuals/r-release/R-lang.html#Comments) only.

All the `.gen.R` suffixed R source code found under [`R/`](https://gitlab.com/rpkg.dev/yay/-/tree/master/R/) is generated from the respective R Markdown counterparts under [`Rmd/`](https://gitlab.com/rpkg.dev/yay/-/tree/master/Rmd/) using [`pkgpurl::purl_rmd()`](https://pkgpurl.rpkg.dev/dev/reference/purl_rmd.html)[^1]. Always make changes only to the `.Rmd` files – never the `.R` files – and then run `pkgpurl::purl_rmd()` to regenerate the R source files.

### Coding style

This package borrows a lot of the [Tidyverse](https://www.tidyverse.org/) design philosophies. The R code adheres to the principles specified in the [Tidyverse Design Guide](https://principles.tidyverse.org/) wherever possible and is formatted according to the [Tidyverse Style Guide](https://style.tidyverse.org/) (TSG) with the following exceptions:

-   Line width is limited to **160 characters**, double the [limit proposed by the TSG](https://style.tidyverse.org/syntax.html#long-lines) (80 characters is ridiculously little given today’s high-resolution wide screen monitors).

    Furthermore, the preferred style for breaking long lines differs. Instead of wrapping directly after an expression’s opening bracket as [suggested by the TSG](https://style.tidyverse.org/syntax.html#long-lines), we prefer two fewer line breaks and indent subsequent lines within the expression by its opening bracket:

    ``` r
    # TSG proposes this
    do_something_very_complicated(
      something = "that",
      requires = many,
      arguments = "some of which may be long"
    )

    # we prefer this
    do_something_very_complicated(something = "that",
                                  requires = many,
                                  arguments = "some of which may be long")
    ```

    This results in less vertical and more horizontal spread of the code and better readability in pipes.

-   Usage of [magrittr’s compound assignment pipe-operator `%<>%`](https://magrittr.tidyverse.org/reference/compound.html) is desirable[^2].

-   Usage of [R’s right-hand assignment operator `->`](https://rdrr.io/r/base/assignOps.html) is not allowed[^3].

-   R source code is *not* split over several files as [suggested by the TSG](https://style.tidyverse.org/package-files.html) but instead is (as far as possible) kept in the single file [`Rmd/yay.Rmd`](https://gitlab.com/rpkg.dev/yay/-/tree/master/Rmd/yay.Rmd) which is well-structured thanks to its [Markdown support](#r-markdown-format).

As far as possible, these deviations from the TSG plus some additional restrictions are formally specified in [`pkgpurl::default_linters`](https://pkgpurl.rpkg.dev/reference/default_linters), which is (by default) used in [`pkgpurl::lint_rmd()`](https://pkgpurl.rpkg.dev/reference/lint_rmd), which in turn is the recommended way to lint this package.

---

[^1]: The very idea to leverage the R Markdown format to author R packages was originally proposed by Yihui Xie. See his excellent [blog post](https://yihui.name/rlp/) for his point of view on the advantages of literate programming techniques and some practical examples. Note that using `pkgpurl::purl_rmd()` is a less cumbersome alternative to the Makefile approach outlined by him.

[^2]: The TSG [explicitly instructs to avoid this operator](https://style.tidyverse.org/pipes.html#assignment-2) – presumably because it’s relatively unknown and therefore might be confused with the forward pipe operator `%>%` when skimming code only briefly. I don’t consider this to be an actual issue since there aren’t many sensible usage patterns of `%>%` at the beginning of a pipe sequence inside a function – I can only think of creating side effects and relying on [R’s implicit return of the last evaluated expression](https://rdrr.io/r/base/function.html). Therefore – and because I really like the `%<>%` operator – it’s usage is welcome.

[^3]: The TSG [explicitly accepts `->` for assignments at the end of a pipe sequence](https://style.tidyverse.org/pipes.html#assignment-2) while Google’s R Style Guide [considers this bad practice](https://google.github.io/styleguide/Rguide.html#right-hand-assignment) because it “makes it harder to see in code where an object is defined”. I second the latter.
