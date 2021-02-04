class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  # validation, stocks must have a name and ticker symbol
  validates :name, :ticker, presence: true

  # find stocks based on the ticker symbol
  def self.new_lookup(ticker_symbol)
    # creating a new IEX ruby client
    client = IEX::Api::Client.new(
      # insert keys using encrypted credentials in credentials.yml.enc
      publishable_token: Rails.application.credentials.iex_client[:publishable_key],
      secret_token: Rails.application.credentials.iex_client[:secret_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    # rescue error when the ticker symbol is not found
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue
      return nil
    end
  end

  # check stocks tracked in database
  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
