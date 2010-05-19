class OrderGroupMailer < ActionMailer::Base
  def receipt(order_group)
    recipients  order_group.user.shop.correspondent ? order_group.user.shop.correspondent : 'os@baze.dk'
    bcc         (order_group.user.email_address.nil? or order_group.user.email_address.net.blank?) ? nil : "#{order_group.user.email_address.name} <#{order_group.user.email_address.text}>"
    from        'Baze A/S <info@baze.dk>'
    subject     "#{order_group.user.shop.name}, Ordre ##{order_group.id}"
    sent_on     Time.now
    body        :order_group => order_group, :shop => order_group.user.shop, :user => order_group.user
    content_type 'text/html'
  end

  def user_receipt(order_group)
    recipients  order_group.user.email
    bcc         (order_group.user.email_address.nil? or order_group.user.email_address.net) ? nil : "#{order_group.user.email_address.name} <#{order_group.user.email_address.text}>"
    from        'Baze A/S <info@baze.dk>'
    subject     "#{order_group.user.shop.name}, Ordre ##{order_group.id}"
    sent_on     Time.now
    body        :order_group => order_group, :shop => order_group.user.shop, :user => order_group.user
    content_type 'text/html'
  end
end
