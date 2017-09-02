class MonzoTransaction < ApplicationRecord

  def amount_in_pounds
    "&#163;%.2f".html_safe % (self.amount.to_f / 100)
  end


  def self.balance
    "&#163;%.2f".html_safe % (MonzoTransaction.sum(:amount) / 100)
  end


  def self.get_transactions
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
      MonzoTransaction.where(monzo_id: transaction['id']).first_or_create(
        description: transaction['description'],
        amount: transaction['amount'],
        currency: transaction['currency'],
        merchant: transaction['merchant'].to_json,
        created_at: DateTime.parse(transaction['created']),
        updated_at: Time.now
      )
    end

    return json
  end

end
