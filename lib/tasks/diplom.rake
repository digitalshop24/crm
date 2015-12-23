namespace :diplom do
  desc "Rake task to get events data"
  task :deadline => :environment do
    date =  Time.zone.now.to_s.slice(0..9)
    Order.connection
    Order.all.each do |order|
      order_date = order.employee_deadline.to_s.slice(0..9)
      if date == order_date
        event_params = {:event_type => "оповещение", :link => "orders/#{order.id}" }
        event = Event.new(event_params)
        event.save
        p "deadline detected!"
      end
    end
    p "finish"
  end

 
end