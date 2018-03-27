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
    data.each do |key, value|
      existing_ticker = Ticker.find_by_ticker_id(key)
      next unless existing_ticker.nil? #不存在就建立一个
      ticker_data = value['ticker']
      Ticker.create!( ticker_id: key,
                      at: value['at'],
                      buy: ticker_data['buy'],
                      sell: ticker_data['sell'],
                      low: ticker_data['low'],
                      high: ticker_data['high'],
                      last: ticker_data['last'],
                      vol: ticker_data['vol']) #请部分是你的数据库的值，=> 后面是你获取的数据的值
    end


     redirect_to ticker_path
  end
end
