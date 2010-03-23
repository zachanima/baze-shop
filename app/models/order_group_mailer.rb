class OrderGroupMailer < ActionMailer::Base
  def receipt(order_group)
    recipients  'os@baze.dk'
    bcc         [order_group.user.shop.email_addresses.empty? ? nil : order_group.user.shop.email_addresses.collect { |e| "#{e.name} <#{e.text}>" }, order_group.user.email].flatten.compact
    from        'Baze A/S <info@baze.dk>'
    subject     "#{order_group.user.shop.name}, Ordre ##{order_group.id}"
    sent_on     Time.now
    body        :order_group => order_group, :shop => order_group.user.shop, :user => order_group.user
    content_type 'text/html'
  end
end
