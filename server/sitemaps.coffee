sitemaps.config('rootUrl', 'https://voteup.io/')
sitemaps.add '/sitemap.xml', ->
  [
    {
      page: '/'
    }
    {
      page: '/privacy'
      lastmod: new Date(2017, 8 - 1, 20)
    }
    {
      page: '/terms'
      lastmod: new Date(2017, 8 - 1, 20)
    }
  ]
