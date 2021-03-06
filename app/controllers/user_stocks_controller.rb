class UserStocksController < ApplicationController

  # start tracking in user portfolio
  def create
    # check if the stocks are already in the portfolio
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      # if not create a new Stock object
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    # create a new UserStock relation
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to portfolio"
    redirect_to my_portfolio_path
  end

  # remove stock from tracking in user portfolio
  def destroy
    # find the stock in database using id
    stock = Stock.find(params[:id])
    # find the stock in portfolio using id
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash[:notice] = "Stock #{stock.name} was successfully removed from portfolio"
    redirect_to my_portfolio_path
  end
end
