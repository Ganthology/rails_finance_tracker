# Finance Tracker
This is the finance tracker app from the Complete Ruby on Rails Developer course.

# Description
The finance tracker app connects the user to the IEX Cloud financial API to add latest stock prices to their portfolio.
```iex-ruby-client``` gem are used to connect to the API, ```devise``` gem are used to authenticate the users, ```font-awesome-rails``` for logos used in the app.
The app uses AJAX and Jquery for the retrieve stock price request to avoid full page reload. Bootstrap are used for the styling of the app.

The functions available in this app are:
1. Search stock using ticker symbol
2. Get latest stock price from IEX api
3. Add stocks to portfolio
4. Friends function to look at others portfolio

[Demo Page](https://ganthology-finance-tracker.herokuapp.com/)