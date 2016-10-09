require 'rails_helper'

RSpec.describe "routing to blog_posts" do

  it "routes http://dyl.anjon.es/blog to blog_posts" do
    expect(get: "http://dyl.anjon.es/blog").to route_to(
      url: "blog",
      path: "blog",
      controller: "blog_posts",
      action: "index")
  end

end
