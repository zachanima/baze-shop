module ShopsHelper
  def truncated_status(shop)
    status = shop.status
    if status.count > 1
      [
        status.shift,
        ', <span class="tooltip" title="',
        status.join(', '),
        '">&hellip;</span>'
      ].join
    else
      status.first
    end
  end
end
