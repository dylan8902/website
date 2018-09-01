class IsItAProxyProblemController < ApplicationController
  layout "is_it_a_proxy_problem"


  # GET /
  # GET /.json
  # GET /.xml
  def index
    Project.hit 60

    respond_to do |format|
      format.html
    end
  end


end
