require 'rest_client'
class Mole::DonationsController < ApplicationController
  skip_before_filter :verify_authenticity_token


  # POST /mole/purchase
  # POST /mole/purchase.json
  # POST /mole/purchase.xml
  def create
    check = just_giving_api_call params

    error = 'Donation Failed' if check[:status] != 'Accepted'
    addon = Mole::Addon.where(code: check[:thirdPartyReference]).first if error.nil?
    error = 'Donation is less than price' if error.nil? and addon and check[:amount] < addon.amount
    error = 'Unknown Item' if error.nil? and addon.nil?

    data = {
      environment: params[:env],
      source: params[:source],
      amount: check[:amount],
      mole_addon_id: addon.id,
      facebook_id: params[:facebook_id],
      donation_id: params[:jg]
    } unless error

    if error
      @donation = { error: error }
      status = :unprocessable_entity
    elsif Mole::Donation.where(data).first
      @donation = Mole::Donation.where(data).first
      status = :ok
    else
      @donation = Mole::Donation.new(data)
      if @donation.save
        status = :created
      else
        @donation = @donation.errors
        status = :unprocessable_entity
      end
    end

    respond_to do |format|
      format.html { render 'create', stauts: status, error: @donation } # create.html.erb
      format.json { render json: @donation, callback: params[:callback], status: status }
      format.xml { render xml: @donation, status: status }
    end

  end


  private
    def just_giving_api_call params

      if params[:env] == "sandbox"
        domain = "api-sandbox.justgiving.com"
      else
        domain = "api.justgiving.com"
      end

#      begin
#        response = RestClient.get "https://#{domain}/#{Rails.application.secrets.justgiving_api_key}/v1/donation/#{params[:jg]}"
#        if response.code == 200
#          check = JSON.parse response.body
#        end
#      rescue => e
        check = { status: "Failed" }
 #       logger.error "Checking Mole Donation: #{e.message}"
#      end

      return check
    end
end