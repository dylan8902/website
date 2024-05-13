class UsersController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!, except [:show]
  before_action :authenticate_admin!, only: [:index]

  # GET /users
  # GET /users.json
  # GET /users.xml
  def index
    @users = User.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users, callback: params[:callback] }
      format.xml { render xml: @users }
      format.rss { render 'feed' }
    end
  end


  # GET /users/1
  # GET /users/1.json
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user, callback: params[:callback] }
      format.xml { render xml: @user }
    end
  end


  # GET /users/webauthn
  # GET /users/webauthn.json
  # GET /users/webauthn.xml
  def webauthn_create
    if !current_user.webauthn_id
      current_user.update!(webauthn_id: WebAuthn.generate_user_id)
    end

    @options = WebAuthn::Credential.options_for_create(
      user: { id: current_user.webauthn_id, name: current_user.name },
      exclude: current_user.credentials.map { |c| c.webauthn_id }
    )

    # Store the newly generated challenge somewhere so you can have it
    # for the verification phase.
    session[:creation_challenge] = @options.challenge

    respond_to do |format|
      format.html # webauthn_create.html.erb
      format.json { render json: current_user, callback: params[:callback] }
      format.xml { render xml: current_user }
    end
  end


  # POST /users/webauthn
  # POST /users/webauthn.json
  # POST /users/webauthn.xml
  def webauthn_verify
    begin
      webauthn_credential = WebAuthn::PublicKeyCredentialWithAttestation.new(
        type: params[:type],
        id: params[:id],
        raw_id: params[:rawId],
        client_extension_outputs: params[:clientExtensionResults],
        response:params[:response]
      )
      webauthn_credential.verify(session[:creation_challenge])
      current_user.credentials.create!(
        webauthn_id: webauthn_credential.id,
        public_key: webauthn_credential.public_key,
        sign_count: webauthn_credential.sign_count
      )
    rescue WebAuthn::Error => e
      logger.error(e)
    end

    respond_to do |format|
      format.html # webauthn_verify.html.erb
      format.json { render json: current_user, callback: params[:callback] }
      format.xml { render xml: current_user }
    end
  end


end
