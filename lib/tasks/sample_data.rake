namespace :db do
<<<<<<< HEAD
	desc "Fill database with sample data"
	task populate: :environment do
			User.create!(	name:"Example User",
							email:"examle@railstutorial.org",
							password:"foobar",
							password_confirmation:"foobar")
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n}@railstutorial.org"
			password = "password"
			User.create!(	name: name,
							email: email,
							password: password,
							password_confirmation: password)
		end
	end
=======
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

  end
>>>>>>> ed9ab217685db7350ee9b40c923dbbb7ba99b318
end