class CheckoutController < ApplicationController

    def create
        @item = Item.find(params[:id])
        @session = Stripe::Checkout::Session.create({
            customer: current_user.stripe_customer_id,
            payment_method_types: ['card'],
            line_items: [{
                price: @item.stripe_price_id,
              quantity: 1
            }],
            mode: 'payment',
            # discounts: [{
            #   coupon: '{{COUPON_ID}}',
            # }],
            success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: cancel_url,
          })
          # respond_to do |format|
          #   # format.js 
          # #   redirect_to @session.url, allow_other_host: true
          # end
        redirect_to @session.url, allow_other_host: true
        
    end

  def success
    session_with_expand = Stripe::Checkout::Session.retrieve({id: params[:session_id], expand: ['line_items']})
    session_with_expand.line_items.data.each do |line_item|
      item = Item.find_by(stripe_product_id: line_item.price.product)
      item.increment!(:sales_count)
    end
  end

  def cancel
    redirect_to root_path
  end
end
