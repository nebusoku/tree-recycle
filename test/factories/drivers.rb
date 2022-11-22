FactoryBot.define do
  factory :driver  do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }
    zone

    factory :leader_driver do
      is_leader { true }
    end
  end
end
