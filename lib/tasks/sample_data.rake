namespace :db do
  desc "This loads the development data."
  task :populate => :environment do
    require 'faker'
    Rake::Task['db:reset'].invoke
    # one user
    user1 = User.create(
      :f_name => "Daniel",
      :l_name => "Cho",
      :email => "daniel.cho.programmer@gmail.com",
      :password => "1111",
      :password_confirmation => "1111",
      :signup_code => "HAPPYNEWYEAR"
    )
    # 10 properties
    properties = []
    10.times do |i|
      property = user1.properties.create(
        :city => Faker::Address.city,
        :suburb => Faker::Address.state,
        :street => Faker::Address.street_address,
        :postcode => Faker::Address.zip_code,
        :n_bathroom => rand(1..3),
        :n_room => rand(1..10),
        :note_attributes => { :note => "aaa" }
      )  
      # 2/3 has note
      # if i % 3 != 0
      #   property.note.build
      #   # property.note.build(:note => Faker::Lorem.paragraph(sentence_count = 1))
      # end
      properties << property
    end
  end
end

