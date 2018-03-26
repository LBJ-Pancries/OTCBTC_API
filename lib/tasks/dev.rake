namespace :dev do
  task :fetch_ticker => :environment do
    puts "Fetch ticker data..."
    response = RestClient.get "https://bb.otcbtc.com/api/v2/tickers"
    data = JSON.parse(response.body)
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
    puts "Total: #{Ticker.count} tickers"
  end
end
