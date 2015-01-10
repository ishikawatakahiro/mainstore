class OrderNotifier < ActionMailer::Base
  default from: "wgnc345@yahoo.co.jp"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(order)
@order=order

    @greeting = "Hi"

    mail to: order.email,subject:'subject'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
@order=order
    @greeting = "Hi"

    mail to: order.email,subject:'subject'
  end


  def seller(order)
@order=order

    mail to: 'wgnc345.nc29@gmail.com' ,subject:'ご注文の依頼です。'
  end
end
