require 'rails_helper'

RSpec.describe "routing to static pages" do

  it "routes http://dyl.anjon.es/ to index" do
    expect(get: "http://dyl.anjon.es/").to route_to(
      controller: "static_pages",
      action: "index")
  end

  it "routes http://dyl.anjon.es/who to who" do
    expect(get: "http://dyl.anjon.es/who").to route_to(
      path: "who",
      url: "who",
      controller: "static_pages",
      action: "who")
  end

  it "routes http://dyl.anjon.es/contact to contact" do
    expect(get: "http://dyl.anjon.es/contact").to route_to(
      path: "contact",
      url: "contact",
      controller: "static_pages",
      action: "contact")
  end

  it "routes http://dyl.anjon.es/contact to message" do
    expect(post: "http://dyl.anjon.es/contact").to route_to(
      path: "contact",
      url: "contact",
      controller: "static_pages",
      action: "message")
  end

  it "routes http://dyl.anjon.es/sitemap to sitemap" do
    expect(get: "http://dyl.anjon.es/sitemap").to route_to(
      path: "sitemap",
      url: "sitemap",
      controller: "static_pages",
      action: "sitemap")
  end

  it "routes http://dyl.anjon.es/cron to cron" do
    expect(get: "http://dyl.anjon.es/cron").to route_to(
      path: "cron",
      url: "cron",
      controller: "static_pages",
      action: "cron")
  end

end
