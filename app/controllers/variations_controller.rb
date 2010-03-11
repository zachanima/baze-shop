class VariationsController < ApplicationController
  before_filter :find_product
  before_filter :find_shop

  def index
    @variations = @product.variations.reject { |v| v.option.separator }
  end

  def update_prices
    params[:variations].each do |variation_data|
      variation = Variation.find(variation_data.first)
      variation.price = variation_data.last[:price]
      variation.save
    end
    flash[:notice] = "Updated prices for options of #{@product.name}"
    redirect_to(edit_shop_product_path(@shop, @product))
  end

  private
  def find_product
    @product = Product.find(params[:product_id])
  end
end
