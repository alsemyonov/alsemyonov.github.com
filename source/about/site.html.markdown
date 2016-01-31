# al.semyonov.us

## Features

* Static site built using [Middleman][].
* [OGP][] built into each page

## Project Structure

* `bin/` — executable scripts
  * `bin/middleman` — [Middleman][] script
  * `bin/redeploy` — deploys site to destination
* `data/` — [YAML][] vocabularies and collections for different modules of site
* `source/` — source of website

## Site structure

Following structure is represented in `source` directory:

*   [ ] [`/`](/) — the main page of your website
    *   [x] [`/index.html`](/)
        *   [x] info about author
        *   [x] structure of website
        *   [x] shows yearly list of all articles
        *   [x] lists all software
    *   [ ] [`/robots.txt`][robots.txt] — [The Robots Exclusion protocol][robotstxt.org] endpoint
        *   [ ] allows robots to see `/blog`, `/cv`, `/me`, `/software`, `/world`
        *   [x] points to [`/sitemap.xml`][sitemap.xml]
        *   [x] points to preferred domain name
    *   [x] [`/humans.txt`][humans.txt] — [humansTXT protocol][humanstxt.org] endpoint
    *   [x] [`/sitemap.xml`][sitemap.xml] — [The Sitemaps protocol][sitemaps.org] endpoint
* [ ] `/blog/`
    *   [ ] [`/blog/index.html`](blog/index.html)
        *   [ ] shows latest article from blog
        *   [x] shows paginated list of latest articles
* [x] `/cv/`
* [ ] `/me/`
* [ ] `/software/`
* [ ] `/world/`

## Data

### Data Vocabularies

* `data/ogp.yml` - Global OGP properties that would be used as defaults for OGP meta tags for every page

### Data Collections

* `data/projects.yml` - List of global OGP properties that would be used as defaults for OGP meta tags for every page

[Middleman]: https://middlemanapp.com/ "Middleman: Hand-crafted frontend development"

[OGP]: http://ogp.me/ "The Open Graph protocol"
[YAML]: http://yaml.org/ "YAML Ain't Markup Language"
[robotstxt.org]: http://www.robotstxt.org/ "The Robots Exclusion Protocol"
[humanstxt.org]: http://humanstxt.org/ "Humans TXT: We Are People, Not Machines."
[sitemaps.org]: http://www.sitemaps.org/ "The Sitemaps protocol"

[root_url]: https://al.semyonov.us/ "The Main Page of Site"
[robots.txt]: https://al.semyonov.us/robots.txt "The Robots Exclusion Protocol endpoint"
[sitemap.xml]: https://al.semyonov.us/sitemap.xml "Sitemap Protocol endpoint"
[humans.txt]: https://al.semyonov.us/humans.txt "The Humans.txt"

*[OGP]: The Open Graph protocol
*[YAML]: YAML Ain't Markup Language
