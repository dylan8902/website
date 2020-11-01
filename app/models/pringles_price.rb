class PringlesPrice < ApplicationRecord
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


  def self.winner
    tesco = PringlesPrice.tesco.first
    asda = PringlesPrice.asda.first
    if tesco and asda
      if tesco.price_inc_offer < asda.price_inc_offer
        return tesco
      elsif tesco.price_inc_offer > asda.price_inc_offer
        return asda
      else
        return asda
      end
    end
  end


  def self.get_tesco_pringles

    url = "https://dev.tescolabs.com/grocery/products/?query=pringles%20vinegar&offset=0&limit=5"
    begin
      response = RestClient.get url, { "Ocp-Apim-Subscription-Key": Rails.application.secrets.tesco_api_key }
    rescue => e
      logger.info "Tesco pringles search problem: " + e.message
      return
    end
    return if response.code != 200

    json = JSON.parse response.body
    if json["uk"]["ghs"]["products"]["results"].size > 0
      p = json["uk"]["ghs"]["products"]["results"][0]
      price = PringlesPrice.new
      price.supermarket = "Tesco"
      price.price = p["price"]
      price.offer = p["PromotionDescription"]
      price.price_inc_offer = parse_tesco_offer p
      return price
    else
      logger.info "Tesco pringles missing: " + e.message
      return nil
    end
  end


  def self.get_asda_pringles
    url = "https://api-groceries.asda.com/api/items/view?itemid=910003061998"

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
    if p["PromotionDescription"] == "Any 2 for £3.00"
      return 1.50
    elsif p["PromotionDescription"] == "Buy 1 Get 1 FREE Cheapest Product..."
      return p["price"] / 2
    end
    return p["price"]
  end


  def self.parse_asda_offer p
    return p["price"].gsub(/[^\d^\.]/, '').to_f
  end


  def self.update
    return if PringlesPrice.where("created_at > ?", Date.today).count > 0
    asda = get_asda_pringles
    asda.save if asda
    tesco = get_tesco_pringles
    tesco.save if tesco
  end


end
