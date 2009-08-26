class Wish < ActiveRecord::Base
  belongs_to :user


  def self.update_quantity_with(wish)
    existing_wish = Wish.find_by_user_id_and_shop_id_and_sku(wish.user_id, wish.shop_id, wish.sku)
    if existing_wish
      existing_wish.quantity += wish.quantity
      existing_wish.save!
      return existing_wish
    else
      wish.save!
      return wish
    end
  end

end
