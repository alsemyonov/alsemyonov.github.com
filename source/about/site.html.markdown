# al.semyonov.us

## Features

* Static site built using [Middleman][].
* [OGP][] built into each page

## Project Structure

* `bin/` - executable scripts
  * `bin/middleman` - [Middleman][] script
  * `bin/redeploy` - deploys site to destination
* `data/` - `YAML` vocabularies and collections for different modules of site
* `source/` - source of website

## Site structure

Following structure is represented in `source` directory:

*   [ ] [`/`][root_url]
    * [ ] [`/robots.txt`][robots.txt]
        * [ ] allows robots to see `/blog`, `/cv`, `/me`, `/software`, `/world`
        * [x] points to [sitemap.xml][]
    * [x] [`/sitemap.xml`][sitemap.xml]
    * [ ] [`/humans.txt`][humans.txt]
* [ ] `/blog/`
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
[root_url]: https://al.semyonov.us/ "The Main Page of Site"
[robots.txt]: https://al.semyonov.us/robots.txt "The Robots Exclusion Protocol endpoint"
[sitemap.xml]: https://al.semyonov.us/sitemap.xml "Sitemap Protocol endpoint"
[humans.txt]: https://al.semyonov.us/humans.txt "The Humans.txt"

*[OGP]: The Open Graph protocol
