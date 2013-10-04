class TimesTablesController < ApplicationController
  
  # GET /timestables
  # GET /timestables.json
  def index
    Project.hit 50
    @timestables = TimesTable.limit(10)
 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @timestables, callback: params[:callback] }
      format.xml { render xml: @timestables }
    end
      
  end
  
  
  # POST /timestables
  # POST /timestables.json
  # POST /timestables.json
  def new
    
    table = Array.new
    
    params[:table].each do |t|
      t = t.to_i
      (params[:min].to_i..params[:max].to_i).each do |a|
        if params[:mismatch] then
          if rand(0..1) == 1
            table << { question: "<tr><td>#{a}</td><td>x</td><td>#{t}</td><td>=</td><td>  </td></tr>", answer: "<tr><td>#{a}</td><td>x</td><td>#{t}</td><td>=</td><td>#{(a*t)}</td></tr>" }
          else
            table << { question: "<tr><td>#{t}</td><td>x</td><td>#{a}</td><td>=</td><td>  </td></tr>", answer: "<tr><td>#{t}</td><td>x</td><td>#{a}</td><td>=</td><td>#{(a*t)}</td></tr>" }
          end
        else
          table << { question: "<tr><td>#{a}</td><td>x</td><td>#{t}</td><td>=</td><td>  </td></tr>", answer: "<tr><td>#{a}</td><td>x</td><td>#{t}</td><td>=</td><td>#{(a*t)}</td></tr>" }
        end
      end
    end
    
    if params[:random]
      table = table.shuffle
    end
    
    if table.count > params[:questions].to_i
      table = table.slice(0..(params[:questions].to_i-1))
    end
    
    if params[:group] == "other"
      params[:group] = params["group-other"];
    end
    
    @timestable = ""
    
    params['copies'].to_i.times do |a|
      @timestable << "<div>#{params[:group]}<table>"
      table.each do |row|
        @timestable << row[:question]
      end
      @timestable << "</table></div>"
    end
    
    if params['answers'].to_i == 1
      @timestable << "<div>#{params[:group]}<table>"
      table.each do |row|
       @timestable << row[:answer]
      end
      @timestable << "</table></div>"
    end
 
    respond_to do |format|
      format.html { render "print", layout: false } 
      format.json { render json: @timestable, callback: params[:callback] }
      format.xml { render xml: @timestable }
    end
      
  end

end