class TickersController < ApplicationController
  def index
    @tickers = Ticker.all
  end

  def update_ticker
    ticker = Ticker.find(params[:id])
    response = RestClient.get "https://bb.otcbtc.com/api/v2/tickers"
    data = JSON.parse(response.body)

    ticker_data = data['eos_cny']['ticker']
    ticker.update(  ticker_id: data.keys[271],
                    buy: ticker_data['buy'],
                    sell: ticker_data['sell'],
                    low: ticker_data['low'],
                    high: ticker_data['high'],
                    last: ticker_data['last'],
                    vol: ticker_data['vol'])

     redirect_to tickers_path
  end
end
