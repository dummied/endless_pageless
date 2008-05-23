class PagelessController < ApplicationController
  
    def index
    if params[:page]
      @pages = Item.find(:all, :page => {:size => 5, :current => params[:page].to_i})
      @items = @pages.to_a
    else
      @pages = Item.find(:all, :page => {:size => 5, :current => 1})
      @items = @pages.to_a
    end
    respond_to do |format|
      format.html { } # index.rhtml
      format.js { render :action => 'filler' } #filler.rjs
    end
  end

end