class WishlistController < ApplicationController
  before_filter :require_facebook_user

  def add
    new_wish = Wish.new do |w|
      w.user = @user
      [ :sku, :shop_id, :description, :unit_price, :quantity ].each do |a|
        w.send("#{a}=".to_sym, params[a])
      end
    end
    @wish = Wish.update_quantity_with(new_wish)
    flash[:notice] = "product #{@wish.sku} added to wishlist (#{@wish.quantity} total)"
    redirect_to :back
  end

end
