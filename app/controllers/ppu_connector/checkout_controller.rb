require_dependency "ppu_connector/application_controller"
require 'net/http'

module PpuConnector
  class CheckoutController < ApplicationController
    before_action :set_ps

    def create
      @checkout = Ppu::Checkout.new(params.permit(:fullname, :email, :phone, :address, :user_id, :products => []))

      @checkout.payment_system = @payment_system

      if @checkout.save

        payout = 0
        @checkout.products.each do |product_id|
          product = Product.find(product_id)
          product.available = product.available - 1
          product.save
          payout += product.price
        end

        @transaction = Ppu::Transaction.new(:original => 'Offline transaction', :ppu_checkout_id => @checkout.id, :payout => payout)

        if @transaction.save
          if @transaction.ppu_checkout.update(:ppu_transaction_id => @transaction.id)
            render json: {
              checkout: @transaction.ppu_checkout,
              redirect_url: nil
            }, status: :created
          else
            render json: @transaction.ppu_checkout.errors, status: :unprocessable_entity
          end
        else
          render json: @transaction.errors, status: :unprocessable_entity
        end
      else
        render json: @checkout.errors, status: :unprocessable_entity
      end
    end

    private
      def set_ps
        @payment_system = PaymentSystem.find_by(:provider => '/api/ppu_connector/')
      end
  end
end
