#= require 'jquery_payment'
$ ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  $form = $('#purchase')

  $cc_number = $form.find('input[name="credit_card_number"]')
  $cc_number.payment('formatCardNumber')

  $cc_cvc = $form.find('input[name="credit_card_cvc"]')
  $cc_cvc.payment('formatCardCVC')

  $cc_expiry = $form.find('input[name="credit_card_expiry"]')
  $cc_expiry.payment('formatCardExpiry')

  $form.submit ->
    Stripe.card.createToken({
      number:    $cc_number.val()
      cvc:       $cc_cvc.val()
      exp_month: $cc_expiry.payment('cardExpiryVal')['month']
      exp_year:  $cc_expiry.payment('cardExpiryVal')['year']
    }, stripe_response_handler)
    false

  stripe_response_handler = (status, response) ->
    if response.error
      $form.find('#error').text(response.error.message)
    else
      $form.find('input[name="stripe_token"]').val(response['id'])
      $form.get(0).submit()