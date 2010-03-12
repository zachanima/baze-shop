class OrderGroupMailer < ActionMailer::Base
  def receipt(order_group)
    recipients  'zachanima@gmail.com'
    from        "Baze A/S <info@baze.dk>"
    subject     "#{order_group.user.shop.name}, Ordre ##{order_group.id}"
    sent_on     Time.now
    body        :order_group => order_group, :shop => order_group.user.shop, :user => order_group.user
  end
end
