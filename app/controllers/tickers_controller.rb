class TickersController < ApplicationController
  def index
    @tickers = Ticker.all
  end

  def show
    @ticker = Ticker.find(params[:id])
  end

  def update_ticker
    response = RestClient.get "https://bb.otcbtc.com/api/v2/tickers"
    data = JSON.parse(response.body)
    ticker = Ticker.find(params[:id])

    ticker_data = data['eos_cny']['ticker']
    ticker.update(  ticker_id: ticker['ticker_id'],
                    buy: ticker_data['buy'],
                    sell: ticker_data['sell'],
                    low: ticker_data['low'],
                    high: ticker_data['high'],
                    last: ticker_data['last'],
                    vol: ticker_data['vol'])
    redirect_to ticker_path
  end
end
