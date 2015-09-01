User.create(name: "Duyet", role: "supervisor",
  email: "duyet.vn@gmail.com",
  password: "12341234", password_confirmation: "12341234",
  remote_avatar_url: "http://res.cloudinary.com/dtls0k5em/image/upload/c_fit,g_north,r_5,w_200/v1440927048/orc3k6urhprnk0huda2n.jpg")
User.create(name: "thuc", role: "normal",
  email: "thuc.vn@gmail.com",
  password: "12341234", password_confirmation: "12341234")
User.create(name: "Nam", role: "trainee",
  email: "nam.vn@gmail.com",
  password: "12341234", password_confirmation: "12341234")

20.times do |n|
  title = Faker::Name.title
  description = Faker::Lorem.paragraph(4)
  Subject.create!(title: title, description: description)
end

subjects = Subject.order(:created_at)

subjects.each do |subject|
  12.times do |i|
    title = Faker::Name.title
    description = Faker::Lorem.paragraph(4)
    subject.tasks.create!(title: title, description: description)
  end
end

10.times do |n|
  title = Faker::Name.title
  description = Faker::Lorem.paragraph(5)
  start_date = Date.today().strftime("%F")
  end_date =  (Date.today() + rand(1..100).days).strftime("%F")
  Course.create!(title: title, description: description,
    start_time: start_date, end_time: end_date)
end

courses = Course.order(:created_at)
