namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end    

  def make_users
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

  def make_microposts
    User.limit(6).each do |user|
      50.times do |_|
        user.microposts.create(content: Faker::Lorem.sentence(5))
      end
    end    
  end

  def make_relationships
    users = User.all
    user = users.first
    followed = users[2..50]
    followers = users[3..40]
    followed.each { |followed| user.follow!(followed) }
    followers.each { |follower| follower.follow!(user) }
  end

end