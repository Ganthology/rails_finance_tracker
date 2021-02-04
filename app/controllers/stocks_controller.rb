class StocksController < ApplicationController
  def search
    # if the input field is not empty
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      # if the stock exists
      if @stock
        # render the javascript
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      # if the stock does not exist
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol"
          format.js { render partial: 'users/result' }
        end
      end
    # if the input field is empty
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol to search"
        format.js { render partial: 'users/result' }
      end
    end
  end
end