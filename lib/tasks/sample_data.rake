namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(
        name: "User Name",
        email: "e@mail.com",
        password: "foobar",
        password_confirmation: "foobar",
        admin: true)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n}@railstutorial.org"
      password = "password"
      User.create!(
          name: name,
          email: email,
          password: password,
          password_confirmation: password)
    end

    User.limit(6).each do |user|
      50.times do |_|
        user.microposts.create(content: Faker::Lorem.sentence(5))
      end
    end

  end
end