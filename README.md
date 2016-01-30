---
title: Об этом сайте
---

# al.semyonov.us

## Features

* [OGP][] built into each page

## Project Structure

* `bin/` - executable scripts
  * `bin/middleman` - [Middleman][] script
  * `bin/redeploy` - deploys site to destination
* `data/` - `YAML` vocabularies and collections for different modules of site
* `source/` - source of website

## Про этот сайт ([al.semyonov.us](https://al.semyonov.us/))

Following structure is represented in `source` directory:

* [ ] [`/`][]
  * [ ] [`/robots.txt`][]
    * [x] points to `/sitemap.xml`
  * [x] [`/sitemap.xml`][]

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

[Middleman]: https://middlemanapp.com/	"Middleman: Hand-crafted frontend development"
[`/`]: https://al.semyonov.us/ "The Main Page of Site"
[`/robots.txt`]: https://al.semyonov.us/robots.txt "The Robots Exclusion Protocol endpoint"
[`/sitemap.xml`]: https://al.semyonov.us/sitemap.xml "Sitemap Protocol endpoint"
[OGP]: http://ogp.me/
