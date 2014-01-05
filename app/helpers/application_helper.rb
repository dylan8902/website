require 'digest/md5'
module ApplicationHelper

  # Creates a full title to be used in HTML head
  def full_title page_title 
    base_title = "Dylan Jones"
    if page_title.empty?
      base_title
    else
      "#{base_title}:: #{page_title}"
    end
  end
  
  # Returns HTML time element with correct timestamps and pretty printed time
  def timestamp time, unknown = "Unknown"
    return unknown if time.nil? or time == 0
    time = Time.at(time.to_i)
    if time.future?
      future = "from now"
    else
      future = "ago"
    end
    "<time class=\"ago\" title=\"#{time}\" datetime=\"#{time.xmlschema}\" data-timestamp=\"#{time.to_i}\">#{time_ago_in_words time} #{future}</time>".html_safe
  end
  
  # Finds and converts all links to HTML <a> elements
  def linkify html
    linked = html.gsub( %r{http(s)?://[^\s<]+} ) do |url|
      if url[/(?:png|jpe?g|gif|svg)$/]
        "<img src=\"#{url}\">"
      else
        "<a href=\"#{url}\" target=\"_blank\">#{url}</a>"
      end
    end
    return linked.html_safe
  end
  
  #returns my age today
  def get_age
    now = Time.now
    dob = Time.parse("22/02/1989")
    now.year - dob.year - (dob.to_time.change(:year => now.year) > now ? 1 : 0)
  end
  
  #awesome icons
  def icon icon
    "<i class=\"icon-#{icon}\"></i>".html_safe
  end
  
  #do they want detailed train view
  def detailed_train_view?
    unless signed_in?
      return false
    else
      return current_user.settings.detailed_view
    end
  end
  
  #gravatar icon
  def gravatar(email, size = 30)
    src = "http://www.gravatar.com/avatar/#{Digest::MD5::hexdigest(email.strip.downcase)}.jpg?s=#{size}&d=identicon"
    return image_tag(src, { alt: "Gravatar", width: size, height: size, class: "img-circle" })
  end
  
  #error messages in forms
  def errors_for(model, attribute)
    if model.errors[attribute].present?
      content_tag :span, :class => 'error_explanation' do
        model.errors[attribute].join(", ")
      end
    end
  end
  
  #bootsrap 3 paginator
  def paginate model
    will_paginate model, renderer: BootstrapPagination::Rails, bootstrap: 3
  end

  
  #the html required to delegate openid to myopenid
  def open_id_delegate
    html = "<link rel=\"openid.server\" href=\"http://www.myopenid.com/server\">\n" +
      "<link rel=\"openid.delegate\" href=\"http://dylanjamesvernonjones.myopenid.com/\">\n" +
      "<link rel=\"openid2.local_id\" href=\"http://dylanjamesvernonjones.myopenid.com\">\n" +
      "<link rel=\"openid2.provider\" href=\"http://www.myopenid.com/server\">"
    return html.html_safe
  end

  #MD5 stuff
  def md5 string
    Digest::MD5.hexdigest string
  end

  #RSS feed
  def rss_link url
    return "<link rel=\"alternate\" type=\"application/rss+xml\" title=\"RSS\" href=\"#{url}.rss\">".html_safe
  end

end