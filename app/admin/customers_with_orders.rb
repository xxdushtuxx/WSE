# app/admin/customers_with_orders.rb
ActiveAdmin.register_page 'CustomersWithOrders' do
    menu label: 'Customers with Orders'#, parent: 'Admin'
  
    content title: 'Customers with Orders' do
      customers = Customer.includes(orders: { order_items: :product })
  
      customers.each do |customer|
        panel "Customer: #{customer.first_name} #{customer.first_name}" do
          table_for customer.orders do
            column 'Order ID', :id
            column 'Order Date', :created_at
            column 'Products Ordered' do |order|
              order.order_items.map { |item| item.product.name }.join(', ')
            end
            column 'Taxes', :tax
            column 'Grand Total', :total_price
          end
        end
      end
    end
  end
  