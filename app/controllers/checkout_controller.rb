class CheckoutController < ApplicationController

    def create
        @session = Stripe::Checkout::Session.create({
            customer: current_user.stripe_customer_id,
            payment_method_types: ['card'],
            line_items: @cart.collect { |item| item.to_builder.attributes! },
            allow_promotion_codes: true,
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
    if params[:session_id].present?
      session[:cart] = []
      @session_with_expand = Stripe::Checkout::Session.retrieve({id: params[:session_id], expand: ['line_items']})
      @session_with_expand.line_items.data.each do |line_item|
        item = Item.find_by(stripe_product_id: line_item.price.product)
        item.increment!(:sales_count)
      end
    else
    redirect_to cancel_path, alert: 'Transaction was cancelled'
    end
  end

  def cancel
  end
end
