SitemapGenerator::Sitemap.default_host = "https://www.vitalefrancesca.com"

SitemapGenerator::Sitemap.create do
  add "/", changefreq: "weekly", priority: 1.0
  add "/chi_sono", changefreq: "monthly", priority: 0.8
  add "/piani_alimentari", changefreq: "monthly", priority: 0.8
  add "/gestione-peso", changefreq: "monthly", priority: 0.8
  add "/gravidanza", changefreq: "monthly", priority: 0.8
  add "/patologie", changefreq: "monthly", priority: 0.8
  add "/sport", changefreq: "monthly", priority: 0.8
  add "/prenota-consulenza-gratuita", changefreq: "weekly", priority: 0.9
end
