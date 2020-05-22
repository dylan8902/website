class BingoNumbersController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!
  before_action :authenticate_admin!
  layout "bingo"


  # GET /bingo/numbers
  # GET /bingo/numbers.json
  # GET /bingo/numbers.xml
  def index
    limit = params[:limit] || BingoNumber.count
    @page = { page: params[:page], per_page: limit.to_i }
    @order = params[:order] || "id"

    @bingo_numbers = BingoNumber.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bingo_numbers, callback: params[:callback] }
      format.xml { render xml: @bingo_numbers }
      format.rss { render 'feed' }
    end
  end


  # GET /bingo/numbers/1/edit
  def edit
    @bingo_number = BingoNumber.find(params[:id])
  end


  # PUT /bingo/numbers/1
  # PUT /bingo/numbers/1.json
  def update
    @bingo_number = BingoNumber.find(params[:id])

    respond_to do |format|
      if @bingo_number.update_attributes(bingo_number_params)
        format.html { redirect_to bingo_numbers_path, notice: 'Bingo number was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bingo_number.errors, status: :unprocessable_entity }
      end
    end
  end


  # POST /bingo/numbers/setup
  # POST /bingo/numbers/setup.json
  def setup
    BingoNumber.where(id:  1).first_or_create(instruction: "Kelly's Eye", song_name: "Hit me baby one more time!", song_url: "")
    BingoNumber.where(id:  2).first_or_create(instruction: "One little duck", song_name: "", song_url: "")
    BingoNumber.where(id:  3).first_or_create(instruction: "Cup of tea", song_name: "Macarena", song_url: "http://127.0.0.1:8080/Various%20Artists/Ultimate%20Party%20Animal%20Album%20Di/08%20Macarena%20_Bayside%20Boys%20Mix_.mp3")
    BingoNumber.where(id:  4).first_or_create(instruction: "Knock at the door", song_name: "", song_url: "")
    BingoNumber.where(id:  5).first_or_create(instruction: "Mambo", song_name: "Mambo No 5", song_url: "http://127.0.0.1:8080/Lou%20Bega%20-%20Mambo%20%235%20(1999).mp3")
    BingoNumber.where(id:  6).first_or_create(instruction: "Half a dozen", song_name: "", song_url: "")
    BingoNumber.where(id:  7).first_or_create(instruction: "Lucky for some", song_name: "S Club", song_url: "http://127.0.0.1:8080/Various%20Artists/Now_%20Vol_%2044%20_UK_%20Disc%202/09%20S%20Club%20Party.mp3")
    BingoNumber.where(id:  8).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id:  9).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 10).first_or_create(instruction: "Boris' Den", song_name: "", song_url: "")
    BingoNumber.where(id: 11).first_or_create(instruction: "Legs Eleven", song_name: "", song_url: "")
    BingoNumber.where(id: 12).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 13).first_or_create(instruction: "Unlucky for some", song_name: "Get Lucky", song_url: "http://127.0.0.1:8080/Daft%20Punk%20feat_%20Pharrell%20Willi/Get%20Lucky/01%20Get%20Lucky%20Radio%20Edit.mp3")
    BingoNumber.where(id: 14).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 15).first_or_create(instruction: "", song_name: "Teenage Dirtbag", song_url: "http://127.0.0.1:8080/Unknown/Clarkson%20Rocks/04%20Teenage%20Dirtbag.mp3")
    BingoNumber.where(id: 16).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 17).first_or_create(instruction: "Dancing Queen", song_name: "", song_url: "")
    BingoNumber.where(id: 18).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 19).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 20).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 21).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 22).first_or_create(instruction: "Two little ducks", song_name: "", song_url: "")
    BingoNumber.where(id: 23).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 24).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 25).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 26).first_or_create(instruction: "", song_name: "Grease", song_url: "http://127.0.0.1:8080/Various%20Artists/50%20Years%20of%20the%20Greatest%20Hit%20S/10%20The%20Grease%20Mega%20Mix.mp3")
    BingoNumber.where(id: 27).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 28).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 29).first_or_create(instruction: "Rise and Shine", song_name: "Mr Briightside", song_url: "http://127.0.0.1:8080/The%20Killers/Hot%20Fuss/02%20Mr%20Brightside.mp3")
    BingoNumber.where(id: 30).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 31).first_or_create(instruction: "Happy Birthday", song_name: "", song_url: "")
    BingoNumber.where(id: 32).first_or_create(instruction: "Didgeridoo", song_name: "", song_url: "")
    BingoNumber.where(id: 33).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 34).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 35).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 36).first_or_create(instruction: "", song_name: "Dancing in the Moonlight", song_url: "")
    BingoNumber.where(id: 37).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 38).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 39).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 40).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 41).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 42).first_or_create(instruction: "", song_name: "Praise You", song_url: "http://127.0.0.1:8080/Various%20Artists/Massive%20Dance%201999_%20Vol_%202%20Dis/06%20Praise%20You.mp3")
    BingoNumber.where(id: 43).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 44).first_or_create(instruction: "Find a fork", song_name: "", song_url: "")
    BingoNumber.where(id: 45).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 46).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 47).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 48).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 49).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 50).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 51).first_or_create(instruction: "Craig David", song_name: "Rewind Bo-Selecta", song_url: "http://127.0.0.1:8080/Various%20Artists/Now_%20Vol_%2045%20_UK_%20Disc%202/04%20Re-Rewind%20When%20the%20Crowd%20Say%20B.mp3")
    BingoNumber.where(id: 52).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 53).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 54).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 55).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 56).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 57).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 58).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 59).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 60).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 61).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 62).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 63).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 64).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 65).first_or_create(instruction: "", song_name: "Cascada", song_url: "http://127.0.0.1:8080/Cascada/Clubland%20Classix/01%20Every%20Time%20We%20Touch.mp3")
    BingoNumber.where(id: 66).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 67).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 68).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 69).first_or_create(instruction: "", song_name: "Summer of 69", song_url: "http://127.0.0.1:8080/Bryan%20Adams/The%20Best%20of%20Me/04%20Summer%20of%20'69.mp3")
    BingoNumber.where(id: 70).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 71).first_or_create(instruction: "Bang on the drum", song_name: "", song_url: "")
    BingoNumber.where(id: 72).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 73).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 74).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 75).first_or_create(instruction: "", song_name: "Bohemium Rhapsody", song_url: "http://127.0.0.1:8080/Queen/Greatest%20Hits%20vol%201/00%20Bohemian%20Rapsody.mp3")
    BingoNumber.where(id: 76).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 77).first_or_create(instruction: "", song_name: "Don't ook back into the sun", song_url: "http://127.0.0.1:8080/The%20Libertines/Don't%20Look%20Back%20Into%20The%20Sun/01%20Don't%20Look%20Back%20Into%20The%20Sun.mp3")
    BingoNumber.where(id: 78).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 79).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 80).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 81).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 82).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 83).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 84).first_or_create(instruction: "", song_name: "MJ - Thriller", song_url: "http://127.0.0.1:8080/Michael%20Jackson/King%20Of%20Pop/03%20Thriller.mp3")
    BingoNumber.where(id: 85).first_or_create(instruction: "Stayin alive", song_name: "", song_url: "")
    BingoNumber.where(id: 86).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 87).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 88).first_or_create(instruction: "Two fat ladies", song_name: "", song_url: "")
    BingoNumber.where(id: 89).first_or_create(instruction: "", song_name: "", song_url: "")
    BingoNumber.where(id: 90).first_or_create(instruction: "", song_name: "", song_url: "")

    respond_to do |format|
      format.html { redirect_to bingo_numbers_path, notice: 'Bingo numbers were successfully setup.' }
      format.json { head :no_content }
    end
  end


  private
    def bingo_number_params
      params.require(:bingo_number).permit(:instruction, :song_name, :song_url)
    end

end
