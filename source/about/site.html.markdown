---
title: About this site
---

[ ![Codeship Status for alsemyonov/alsemyonov.github.com](https://codeship.com/projects/b4c9d280-a68f-0133-2c7c-1a5a40261798/status?branch=master)](https://codeship.com/projects/129976)

## Features

*   [x] Static site built using [Middleman][].
*   [ ] Semantic markup built into each page:
    *   [ ] Meta tags with [OGP][]
    *   [ ] Inline microdata markup with [schema.org][] vocabulary

## Site structure

Following structure is represented in `source` directory:

*   [ ] [`/`](/) — the main page of your website
    *   [x] [`/index.html`](/index.html)
        *   [x] info about author
        *   [x] structure of site
        *   [x] shows yearly list of all articles
        *   [x] lists all software
    *   [ ] [`/robots.txt`][robots.txt]
        *   [x] [The Robots Exclusion protocol][robotstxt.org] endpoint
        *   [ ] allows robots to see `/blog`, `/cv`, `/me`, `/software`, `/world`
        *   [x] points to [`/sitemap.xml`][sitemap.xml]
        *   [x] points to preferred domain name
    *   [x] [`/humans.txt`][humans.txt] — [humansTXT protocol][humanstxt.org] endpoint
    *   [x] [`/sitemap.xml`][sitemap.xml] — [The Sitemaps protocol][sitemaps.org] endpoint
*   [ ] [`/about/`](/about/) — page describing this site contents
    *   [ ] [`/about/index.html`](/about/index.html)
        *   [ ] [`/about/#me`](/about/#me) - information about author of the
    *   [x] [`/about/site.html`](/about/site/) — information about this site (this page).
    *   [x] [`/about/webmaster.html`](/about/webmaster/) — not-published information for webmaster.
*   [ ] [`/blog/`](/blog/)
    *   [ ] [`/blog/index.html`](/blog/index.html)
        *   [ ] shows latest article from blog
        *   [x] shows paginated list of latest articles
* [x] `/cv/`
* [ ] `/me/`
* [ ] `/software/`
* [ ] `/world/`

## Project Structure

* `bin/` — executable scripts
  * `bin/middleman` — [Middleman][] script
  * `bin/redeploy` — deploys site to destination
* `data/` — [YAML][] vocabularies and collections for different modules of site
* `source/` — source of website

## Data

It exposes several common data vocabularies:

*   `data.ogp.*` —
    OGP properties that would be used as defaults for OGP meta tags for every page.
    Loads defaults from `data/ogp.yml`, then overload values from frontmatter.

*   `data.site.*` — exposes information about a website.
    Loads defaults from `data/site.yml`.

    Keys: `host`, `scheme`, `url`, `baseurl`, `title`, `description`.

*   `data.author.*` — exposes information about an author of a website.
    Loads defaults from `data/author.yml`, then overload values from frontmatter.

    Keys: `name`, `email`, `url`.

### Data Collections

* `data.projects` is an array containing list of projects (`Project` class).
  Loads from `data/projects.yml`.

[Middleman]: https://middlemanapp.com/ "Middleman: Hand-crafted frontend development"

[OGP]: http://ogp.me/ "The Open Graph protocol"
[YAML]: http://yaml.org/ "YAML Ain't Markup Language"
[robotstxt.org]: http://www.robotstxt.org/ "The Robots Exclusion Protocol"
[humanstxt.org]: http://humanstxt.org/ "Humans TXT: We Are People, Not Machines."
[sitemaps.org]: http://www.sitemaps.org/ "The Sitemaps protocol"
[schema.org]: http://www.schema.org/ "schema.org microdata vocabulary"

[root_url]: https://al.semyonov.us/ "The Main Page of Site"
[robots.txt]: https://al.semyonov.us/robots.txt "The Robots Exclusion Protocol endpoint"
[sitemap.xml]: https://al.semyonov.us/sitemap.xml "Sitemap Protocol endpoint"
[humans.txt]: https://al.semyonov.us/humans.txt "The Humans.txt"

*[OGP]: The Open Graph protocol
*[YAML]: YAML Ain't Markup Language
