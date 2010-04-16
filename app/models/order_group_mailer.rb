class OrderGroupMailer < ActionMailer::Base
  def receipt(order_group)
    recipients  'zachanima@gmail.com'
    bcc         order_group.user.email_address.nil? ? nil : "#{order_group.user.email_address.name} <#{order_group.user.email_address.text}>"
    from        'Baze A/S <info@baze.dk>'
    subject     "#{order_group.user.shop.name}, Ordre ##{order_group.id}"
    sent_on     Time.now
    body        :order_group => order_group, :shop => order_group.user.shop, :user => order_group.user
    content_type 'text/html'
  end

  def user_receipt(order_group)
    recipients  order_group.user.email
    from        'Baze A/S <info@baze.dk>'
    subject     "#{order_group.user.shop.name}, Ordre ##{order_group.id}"
    sent_on     Time.now
    body        :order_group => order_group, :shop => order_group.user.shop, :user => order_group.user
    content_type 'text/html'
  end
end
