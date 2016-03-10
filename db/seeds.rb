puts 'Clearing all data...'
Subspeciality.destroy_all
Speciality.destroy_all
User.destroy_all
Worktype.destroy_all

puts 'Creating specialities...'
specialities = ['Математика', 'Физика', 'Химия', 'История', 'Программирование', 'Иностранные языки']
subspecialities = ['Математический анализ', 'Ядерная физика', 'Химия жидкостей', 'История России', 'Программирование на C++',
                   'Программирование на Java', 'Физика жидкостей', 'Алгебра', 'Аналитическая геометрия', 'История Китая',
                   'Английский', 'Французский', 'Немецкий']
specialities.each do |speciality|
  sp = Speciality.create!(name: speciality)
  Subspeciality.create!(speciality: sp, subspeciality: subspecialities.sample)
end

puts 'Creating worktypes...'
worktypes = %w[Диплом Курсовая Контрольная]
worktypes.each do |worktype|
  Worktype.create!(name: worktype)
end

roles = %w[Admin Manager Employee Client]
specialities = Speciality.all

puts 'Creating main users...'
roles.each do |role|
  params = {name: role, email: "#{role.downcase}@site.ru", password: ENV['password']}
  if role == 'Employee'
    params[:speciality_ids] = specialities.pluck(:id).sample(2)
    subsp = []
    params[:speciality_ids].each do |sp|
      subsp += Subspeciality.where(speciality_id: sp).pluck(:id).sample(2)
    end
    params[:subspeciality_ids] = subsp
  end
  if (role == 'Client')
    params[:city] = Faker::Lorem.word
  end
  params[:activated] = true
  Object.const_get(role).create!(params)
end

puts 'Creating other users...'
roles[1,3].each do |role|
  rand(15..30).times do
    params = { name: Faker::Name.name,
               email: ('a'..'z').to_a.sample(rand(5..10)).join('') + '@' + ['gmail.com', 'mail.ru', 'mail.by'].sample,
               password: Faker::Internet.password(8),
               phone: Faker::PhoneNumber.cell_phone
               }
    if (role == 'Employee')
      params[:speciality_ids] = specialities.pluck(:id).sample(rand(1..4))
      subsp = []
      params[:speciality_ids].each do |sp|
        subsp += Subspeciality.where(speciality_id: sp).pluck(:id).sample(rand(0..4))
      end
      params[:subspeciality_ids] = subsp
      params[:skype] = Faker::Lorem.word
    end
    if (role == 'Client')
      params[:city] = Faker::Lorem.word
    end
    params[:activated] = [true, false].sample
    Object.const_get(role).create!(params)
  end
end

puts 'Done!!1'
