class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # convenient method to return full name
  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end       

  # check database if the stocks already tracked by user
  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock

    stocks.where(id: stock.id).exists?
  end

  # maximum stock number of 10
  def under_stock_limit?
    stocks.count < 10
  end

  # check both requirement to track more stocks
  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  # match method that checks all fields
  def self.search(param)
    # remove empty spaces around
    param.strip!
    # return unique matched list
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back

    to_send_back
  end

  # match first name
  def self.first_name_matches(param)
    matches('first_name', param)
  end

  # match last name
  def self.last_name_matches(param)
    matches('last_name', param)
  end

  # match email_matches(param)
  def self.email_matches(param)
    matches('email', param)
  end

  # general match method
  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

  # exclude current user
  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end
end
