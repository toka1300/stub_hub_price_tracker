class UpdateLivePriceUsdToInteger < ActiveRecord::Migration[7.2]
  def change
    change_column(:events, :live_price_usd, :integer)
  end
end
