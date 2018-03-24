class CreateTickers < ActiveRecord::Migration[5.1]
  def change
    create_table :tickers do |t|
      t.string :ticker_id
      t.string :at
      t.numeric :buy
      t.numeric :sell
      t.numeric :low
      t.numeric :high
      t.numeric :last
      t.numeric :vol

      t.timestamps
    end
    add_index :tickers, :ticker_id
  end
end
