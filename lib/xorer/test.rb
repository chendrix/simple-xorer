# app/services/credit_card_service.rb

require 'stripe'

class CreditCardService
  def initialize(card)
    @card = card  # now this will fail if card is not passed in
  end

  def charge(amount)
    # This will return a Stripe::Charge object
    external_charge_service.create(merge_attributes(amount: amount ))
  rescue # probably should only be rescuing Stripe/Network errors
    false # probably shouldn't be doing this
  end

  def create_customer(email)
    # This will return a Stripe::Customer object
    external_customer_service.create(merge_attributes(email: email))
  rescue # probably should only be rescuing Stripe/Network errors
    false # probably shouldn't be doing this
  end

  private

  STRIPE_BASE_ATTRIBUTE_HASH = { card: card }

  attr_reader :card

  def external_charge_service
    Stripe::Charge
  end

  def external_customer_service
    Stripe::Customer
  end

  def merge_attributes(hash)
    STRIPE_BASE_ATTRIBUTE_HASH.merge(hash)
  end
end
