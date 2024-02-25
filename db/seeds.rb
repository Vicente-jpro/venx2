# First create at least 2 users after run this seed

puts "Cadastrando as provincias..."
Province.find_or_create_by!(province_name: "Luanda")
Province.find_or_create_by!(province_name: "Úige")
Province.find_or_create_by!(province_name: "Uila")
Province.find_or_create_by!(province_name: "Kuanza Sul")
puts "Fim do cadastro de provincias."

puts "Cadastrando municipios/cidade..."
City.find_or_create_by!(city_name: "Belas", province: Province.first)
City.find_or_create_by!(city_name: "Gabela", province: Province.last)
City.find_or_create_by!(city_name: "Sumbe", province: Province.last)
City.find_or_create_by!(city_name: "Viana", province: Province.first)
puts "Fim do cadastro das municipios/cidade."


puts "Cadastrando as cidades...."
Address.find_or_create_by!(street: "Centralidade do Kilamba", city: City.all.sample)
Address.find_or_create_by!(street: "Rangel rua 17", city: City.all.sample)
Address.find_or_create_by!(street: "Talalice", city: City.all.sample)
Address.find_or_create_by!(street: "Mutamba", city: City.all.sample)
puts "Fim do cadastro das cidades."

puts "Cadastrando usuarios...."
user = User.new 
user.email = "vicenteviciii@gmail.com"
user.password = "12345678"
user.password_confirmation = "12345678"
user.save!

user = User.new
user.email = "vicenteviciii@outlook.com"
user.password = "12345678"
user.password_confirmation = "12345678"
user.save!
puts "Fim do cadastro de usuários."

puts "Cadastrando a empresa...."
Company.find_or_create_by!(
    name: "Adicionatec",
    whatsapp: "9778887777",
    telephone: "9778887777",
    email: "adicionatec@gmail.com",
    nif: "0001233345",
    address: Address.first
)

Company.find_or_create_by!(
    name: "Luisa Tech",
    whatsapp: "955966966",
    telephone: "955966966",
    email: "luisa.tech@gmail.com",
    nif: "156300032",
    address: Address.last
)

puts "Fim do cadastro de empresa."



puts "Cadastrando as perfis...."
Profile.find_or_create_by!(
    name_profile: "Vicente Simão", 
    whatsapp: "144889722",
    telephone: "166666666",
    profile_type: "FUNCIONARIO",
    gender: "MASCULINO",
    identity_card: "12345676LA123",
    address: Address.all.sample,
    user: User.first,
    company: Company.first
)
Profile.find_or_create_by!(
    name_profile: "Vicente Simão", 
    whatsapp: "244889721",
    telephone: "266666666",
    profile_type: "FUNCIONARIO",
    gender: "MASCULINO",
    identity_card: "8765433LA123",
    address: Address.all.sample,
    user: User.last,
    company: Company.last
)
puts "Fim do cadastro de perfis."

puts "Cadastrando os fornecedor...."
Supplier.find_or_create_by!(
    name_supplier: "Vicente Simão", 
    whatsapp: "344889722",
    telephone: "366666666",
    email: "forn@gmail.com",
    address: Address.all.sample,
    profile: Profile.all.sample
)
Supplier.find_or_create_by!(
    name_supplier: "Vicente Simão", 
    whatsapp: "442222222",
    telephone: "494444444",
    email: "fornecedor@gmail.com",
    address: Address.all.sample,
    profile: Profile.all.sample
)
puts "Fim do cadastro do fornecedor."


puts "Cadastrando os sector...."
Sector.find_or_create_by!(
    name_sector: "Alimentos" 
)
Sector.find_or_create_by!(
    name_sector: "Frutos"
)
puts "Fim do cadastro do sector."

puts "Cadastrando os categoria...."
Category.find_or_create_by!(
    name_category: "Alimentação"
)
Category.find_or_create_by!(
    name_category: "Desporto"
)
puts "Fim do cadastro do categoria."

puts "Cadastrando os items...."
Item.find_or_create_by!(
    description: "Arroz branco",
    manufacturing_date: Time.now,
    expiration_date: Time.now,
    quantity: 555,
    price: 4000,
    item_code: 2453452, 
    profite_value: 40,
    supplier: Supplier.first,
    category: Category.first,
    profile: Profile.first,
    sector: Sector.first

)
puts "Fim do cadastro dos items."

puts "Cadastrando os items...."
Item.find_or_create_by!(
    description: "Massa xepa",
    manufacturing_date: Time.now,
    expiration_date: Time.now,
    quantity: 100,
    price: 6000,
    item_code: 4534552, 
    profite_value: 40,
    supplier: Supplier.last,
    category: Category.last,
    profile: Profile.last,
    sector: Sector.last

)
puts "Fim do cadastro dos items."

puts "Cadastrando os cart_temp...."
CartTemp.find_or_create_by!(
    item: Item.first,
    quantity: 2,
    abandoned: true,
    profile: Profile.first
)

CartTemp.find_or_create_by!(
    item: Item.last,
    quantity: 3,
    abandoned: true,
    profile: Profile.last
)
puts "Fim do cadastro dos items."

