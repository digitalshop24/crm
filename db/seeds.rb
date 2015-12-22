Admin.create(email: ENV['admin_email'], password: ENV['password'], name: 'Админ')
Employee.create(email: ENV['employee_email'], password: ENV['password'], name: 'Исполнитель')
Manager.create(email: ENV['manager_email'], password: ENV['password'], name: 'Менеджер')
Client.create(email: ENV['client_email'], password: ENV['password'], name: 'Клиент')

specialities = %w[Математика Физика Химия История Программирование]
specialities.each do |speciality|
  Speciality.create(name: speciality)
end

worktypes = %w[Диплом Курсовая]
worktypes.each do |worktype|
  Worktype.create(name: worktype)
end

roles = %w[Admin Manager Employee Client]
specialities = Speciality.all

roles.each do |role|
  params = {name: role, email: "#{role.downcase}@site.ru", password: '12345678'}
  params[:speciality] = specialities.sample if role == 'Employee'
  Object.const_get(role).create(params)
end

roles[1,3].each do |role|
  rand(15..30).times do
    params = { name: Faker::Name.name,
               email: ('a'..'z').to_a.sample(10).join('') + '@' + ['gmail.com', 'mail.ru'].sample,
               password: Faker::Internet.password(8),
               phone: Faker::PhoneNumber.cell_phone
               }
    if (role == 'Employee')
      params[:speciality] = specialities.sample
      params[:skype] = Faker::Lorem.word
      params[:speciality] = specialities.sample
    end
    if (role == 'Client')
      params[:city] = Faker::Lorem.word
    end
    Object.const_get(role).create!(params)
  end
end
