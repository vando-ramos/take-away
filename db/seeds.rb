# bond = User.create!(name: 'James', last_name: 'Bond', cpf: CPF.generate,
#                     email: 'bond@email.com', password: '123456789aaa',
#                     password_confirmation: '123456789aaa', role: 'admin')

# wick = User.create!(name: 'John', last_name: 'Wick', cpf: CPF.generate,
#                     email: 'wick@email.com', password: '123456789aaa',
#                     password_confirmation: '123456789aaa')

# estab1 = Establishment.create!(user: bond, corporate_name: 'Giraffas Brasil S.A.',
#                               brand_name: 'Giraffas', cnpj: CNPJ.generate,
#                               address: 'Rua Comercial Sul', number: '123',
#                               neighborhood: 'Asa Sul', city: 'Brasília', state: 'DF',
#                               zip_code: '70300-902', phone_number: '2198765432',
#                               email: 'contato@giraffas.com.br')

# estab2 = Establishment.create!(user: wick, corporate_name: 'KFC Brasil S.A.', brand_name: 'KFC',
#                               cnpj: CNPJ.generate, address: 'Av Paulista', number: '1234',
#                               neighborhood: 'Centro', city: 'São Paulo', state: 'SP',
#                               zip_code: '10010-100', phone_number: '1140041234',
#                               email: 'contato@kfc.com.br')

# OperatingHour.day_of_weeks.keys.each do |day|
#   OperatingHour.create!(establishment: estab1, day_of_week: day,
#                         opening_time: '8:00', closing_time: '17:00')
# end

# OperatingHour.day_of_weeks.keys.each do |day|
#   OperatingHour.create!(establishment: estab2, day_of_week: day,
#                         opening_time: '18:00', closing_time: '00:00')
# end

# dish1 = Dish.create!(establishment: estab1, name: 'Pizza de Calabresa',
#                  description: 'Pizza com molho de tomate, queijo, calabresa e orégano',
#                  calories: 265,
#                  image: File.open(Rails.root.join('spec/fixtures/files/pizza-calabresa.jpg')),
#                  status: 'active')

# dish2 = Dish.create!(establishment: estab2, name: 'Macarrão Carbonara',
#                  description: 'Macarrão com molho cremoso à base de ovos, queijo e bacon',
#                  calories: 550,
#                  image: File.open(Rails.root.join('spec/fixtures/files/carbonara.jpg')),
#                  status: 'active')

# drink1 = Drink.create!(establishment: estab1, name: 'Limonada',
#                  description: 'Uma refrescante bebida feita com limões frescos, açúcar e água',
#                  calories: 120, is_alcoholic: 'no', status: 'active',
#                  image: File.open(Rails.root.join('spec/fixtures/files/limonada.jpg')))

# drink2 = Drink.create!(establishment: estab2, name: 'Mojito',
#                  description: 'Um coquetel clássico cubano feito com rum branco, limão, hortelã, açúcar e água com gás',
#                  calories: 150, is_alcoholic: 'yes', status: 'active',
#                  image: File.open(Rails.root.join('spec/fixtures/files/mojito.jpg')))

# DishOption.create!(dish: dish1, price: '30,00', description: 'Média')
# DishOption.create!(dish: dish1, price: '50,00', description: 'Grande')
# DishOption.create!(dish: dish2, price: '30,00', description: 'Médio')
# DishOption.create!(dish: dish2, price: '50,00', description: 'Grande')

# DrinkOption.create!(drink: drink1, price: '5,00', description: '300ml')
# DrinkOption.create!(drink: drink1, price: '8,00', description: '500ml')
# DrinkOption.create!(drink: drink2, price: '15,00', description: '300ml')
# DrinkOption.create!(drink: drink2, price: '20,00', description: '500ml')

# Menu.create!(establishment: estab1, name: 'Dinner', dishes: [dish1, dish2], drinks: [drink1, drink2])

# order = Order.create!(user: bond, establishment: estab1, customer_name: 'Tony Stark',
#                       customer_cpf: CPF.generate, customer_email: 'stark@email.com',
#                       customer_phone: '21987654321', total_value: '55,00')
