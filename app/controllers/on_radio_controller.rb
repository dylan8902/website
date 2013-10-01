class OnRadioController < ApplicationController
  
  # GET /onradio/1
  # GET /onradio/1.json
  # GET /onradio/1.xml
  def one
    
    @radio_station = RadioStation.new(
      id: 'radio1',
      country: '/england',
      key: 'bbc_radio_one',
      title: 'BBC Radio 1',
      colour: '#191919'
    )
        
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @radio_station, callback: params[:callback] }
      format.xml { render xml: @radio_station }
    end
  end
  

  # GET /onradio/1xtra
  # GET /onradio/1xtra.json
  # GET /onradio/1xtra.xml
  def one_xtra
    
    @radio_station = RadioStation.new(
      id: '1xtra',
      country: '',
      key: 'bbc_1xtra',
      title: 'BBC 1Xtra',
      colour: '#191919'
    )
        
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @radio_station, callback: params[:callback] }
      format.xml { render xml: @radio_station }
    end
  end
    
 
  # GET /onradio/2
  # GET /onradio/2.json
  # GET /onradio/2.xml
  def two
    
    @radio_station = RadioStation.new(
      id: 'radio2',
      country: '',
      key: 'bbc_radio_two',
      title: 'BBC Radio 2',
      colour: '#FF6600'
    )
        
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @radio_station, callback: params[:callback] }
      format.xml { render xml: @radio_station }
    end
  end
  
  
  # GET /onradio/3
  # GET /onradio/3.json
  # GET /onradio/3.xml
  def three
    
    @radio_station = RadioStation.new(
      id: 'radio3',
      country: '',
      key: 'bbc_radio_three',
      title: 'BBC Radio 3',
      colour: '#BA3732'
    )
        
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @radio_station, callback: params[:callback] }
      format.xml { render xml: @radio_station }
    end
  end
  
  
  # GET /onradio/6music
  # GET /onradio/6music.json
  # GET /onradio/6music.xml
  def six_music
    
    @radio_station = RadioStation.new(
      id: '6music',
      country: '',
      key: 'bbc_6music',
      title: 'BBC 6 Music',
      colour: '#008A8A'
    )
        
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @radio_station, callback: params[:callback] }
      format.xml { render xml: @radio_station }
    end
  end

end
