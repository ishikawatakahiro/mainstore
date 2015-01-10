atom_feed do |feed|
feed.title"whobought #{@product.title}"

latest_orders.eachdo |order|
feed.entry(order) do |entry|
ebtry.title "order #{order.id}"
entry.summary type: 'xhtml' do|xhtml|
xhtml.p "Shipped to #{order.address}"

xhtml.table do
xhtml.tr do
xhtml.'Product'
xhtml.'Quantity'
xhtml.'Total Price'
end
order.line_items.each do |item|
xhtml.tr do
xhtml.td item.product.title
xhtml.td item.quantity
xhtml.td number_to_currency item.total_price
end
end

xhtml.tr do
xhtml.th 'total',colspan: 2
xhtml.th number_to_currency order.line_items.map(&:total_price).sum
end
end

xhtml.p "Paid by #{order.pay_type}"
end
entry.author do |author|
entry.name order.name
entry.email order.email
end
end
end
end

