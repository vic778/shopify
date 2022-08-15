class CheckoutController < ApplicationController

    def create
        @item = Item.find(params[:id])
        @session = Stripe::Checkout::Session.create({
            customer: current_user.stripe_customer_id,
            payment_method_types: ['card'],
            line_items: [{
                name: @item.name,
                amount: @item.price,
                currency: 'usd',
            #   price: '{{PRICE_ID}}'
              quantity: 1
            }],
            mode: 'payment',
            # discounts: [{
            #   coupon: '{{COUPON_ID}}',
            # }],
            success_url: root_url,
            cancel_url: root_url,
          })
          # respond_to do |format|
          #   # format.js 
          # #   redirect_to @session.url, allow_other_host: true
          # end
        redirect_to @session.url, allow_other_host: true
        
    end
end
