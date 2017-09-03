class MonzoTransaction < ApplicationRecord

  def amount_in_pounds
    "&#163;%.2f".html_safe % (self.amount.to_f / 100)
  end


  def self.balance
    "&#163;%.2f".html_safe % (MonzoTransaction.sum(:amount) / 100)
  end


  def self.update
    url = "https://api.monzo.com/transactions?expand[]=merchant&account_id=#{Rails.application.secrets.monzo_account_id}"
    begin
      response = RestClient.get url, { "Authorization": "Bearer #{Rails.application.secrets.monzo_access_token}" }
    rescue => e
      logger.info "Monzo API error: " + e.message
      return
    end
    return if response.code != 200

    json = JSON.parse response.body

    json['transactions'].each do |transaction|
      if transaction['merchant']
        merchant = transaction['merchant']['name']
        if transaction['merchant']['address']
          lat = transaction['merchant']['address']['latitude']
          lng = transaction['merchant']['address']['longitude']
        end
      end
      MonzoTransaction.where(monzo_id: transaction['id']).first_or_create(
        description: transaction['description'],
        amount: transaction['amount'],
        currency: transaction['currency'],
        merchant: merchant,
        lat: lat,
        lng: lng,
        json: transaction.to_json,
        created_at: DateTime.parse(transaction['created']),
        updated_at: Time.now
      )
    end

    return json
  end

end
