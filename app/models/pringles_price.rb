class PringlesPrice < ActiveRecord::Base
  default_scope { order('created_at DESC') }


  def css_style
    return "background-color:#00539f;border-color:#00539f" if supermarket == "Tesco"
    return "background-color:#78be20;border-color:#78be20" if supermarket == "Asda"    
  end


  def self.tesco
    return PringlesPrice.where(supermarket: "Tesco")
  end


  def self.asda
    return PringlesPrice.where(supermarket: "Asda")
  end


  def self.stats
    tesco = Array.new
    PringlesPrice.tesco.each do |pringles_price|
      tesco << [pringles_price.created_at.strftime("%F"), pringles_price.price]
    end
    asda = Array.new
    PringlesPrice.asda.each do |pringles_price|
      asda << [pringles_price.created_at.strftime("%F"), pringles_price.price]
    end
    return [tesco, asda]
  end


  def self.winner
    tesco = PringlesPrice.tesco.first
    asda = PringlesPrice.asda.first
    if tesco and asda
      if tesco.price < asda.price
        return tesco
      elsif tesco.price > asda.price
        return asda
      else
        return asda
      end
    end
  end


  def self.get_tesco_session
    url =  "https://secure.techfortesco.com/tescolabsapi/restservice.aspx?command=LOGIN&email=" +
            ENV['TESCO_EMAIL'] + "&password=" + ENV['TESCO_PASSWORD'] + "&developerkey=" +
            ENV['TESCO_DEV_KEY'] + "&applicationkey=" + ENV['TESCO_APP_KEY']
    begin
      response = RestClient.get url
    rescue => e
      logger.info "Tesco pringles login problem: " + e.message
      return
    end
    return if response.code != 200
    json = JSON.parse response.body
    return json['SessionKey']
  end


  def self.get_tesco_pringles
    key = get_tesco_session
    return if key.nil?

    ean = "5410076462285"
    url = "https://secure.techfortesco.com/tescolabsapi/restservice.aspx?command=PRODUCTSEARCH&searchtext=" +
          ean + "&page=1&sessionkey=" + key
    begin
      response = RestClient.get url
    rescue => e
      logger.info "Tesco pringles search problem: " + e.message
      return
    end
    return if response.code != 200

    json = JSON.parse response.body
    if json["Products"].size > 0
      p = json["Products"][0]
      price = PringlesPrice.new
      price.supermarket = "Tesco"
      price.price = p["Price"]
      price.offer = p["OfferPromotion"]
      price.price_inc_offer = parse_tesco_offer p
      return price
    else
      return nil
    end
  end


  def self.get_asda_pringles
    url = "https://api-groceries.asda.com/api/items/view?itemid=910001592613"

    begin
      response = RestClient.get url
    rescue => e
      logger.info "Asda pringles search problem: " + e.message
      return
    end

    return if response.code != 200
    json = JSON.parse response.body
    if json["items"].size > 0
      p = json["items"][0]
      price = PringlesPrice.new
      price.supermarket = "Asda"
      price.price = p["price"].gsub(/[^\d^\.]/, '').to_f
      price.offer = p["promoDetailFull"]
      price.price_inc_offer = parse_asda_offer p
      return price
    else
      return nil
    end
  end


  def self.parse_tesco_offer p
    if p["OfferPromotion"] == "Any 2 for £3.00"
      return 1.50
    end
    return p["Price"]
  end


  def self.parse_asda_offer p
    return p["price"].gsub(/[^\d^\.]/, '').to_f
  end


  def self.update
    return if PringlesPrice.where("created_at > ?", Date.today).count > 0
    asda = get_asda_pringles
    asda.save
    tesco = get_tesco_pringles
    tesco.save
  end


end