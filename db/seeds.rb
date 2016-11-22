# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


## Create 10 users:
["a", "b", "c", "d","e" ].each do |n|
  User.create(
    email: "#{n}@example.com",
    password: "#{n.*6}",
    name: "#{n*3}"
  )
end

## Create 10 doctors:
["g", "h", "i", "j",  "k"].each do |n|
  Doctor.create(
    email: "#{n}@example.com",
    password: "#{n.*6}",
    name: "#{n*3}",
    expertise: 'Nhi'
  )
end

clinic_list = [
    [ "Phòng khám Đa khoa Medelab", "86-88 Nguyễn Lương Bằng, Quang Trung, Đống Đa, Hà Nội", 21.018516, 105.842071, "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-11_020720.3832380000.jpeg"],
    [ "Phòng khám Đa khoa Quốc tế, International SOS Hồ Chí Minh - Cơ sở 2", "167A Nam Kỳ Khởi Nghĩa, 7, Quận 3, Hồ Chí Minh", 10.78378, 106.69003, "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-02_071914.4940130000.jpeg" ],
    [ "Phòng khám,  Đa khoa Quốc Tế VietSing", "Pacific Place 83B Lý Thường Kiệt, Lý Thường Kiệt, Hoàn Kiếm, Hà Nội ", 21.025371, 105.843433, "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_182933.2461330000.jpeg" ],
    [ "Phòng khám Vietlife MRI", "14 Trần Bình Trọng, Hai Bà Trưng, Hoàn Kiếm, Hà Nội", 21.020742, 105.844517, "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-12_043002.6635410000.jpeg" ],
    [ "Phòng Khám Đa khoa 70 Nguyễn Chí Thanh (VIETDOCTOR) - Cơ sở 1", "70 Nguyễn Chí Thanh, Láng Thượng, Đống Đa, Hà Nội", 21.01867, 105.8073, "https://dwbxi9io9o7ce.cloudfront.net/images/2016-01-12_071554.5350500000.jpeg"],
    [ "Phòng khám Nhi - Bác sĩ Đào Trung Hiếu", "8 Nguyễn Trọng Tuyển, 15, Phú Nhuận, Hồ Chí Minh", 10.79726, 106.68057, "https://dwbxi9io9o7ce.cloudfront.net/images/2016-03-17_064855.2413680000.jpeg" ],
    [ "Phòng khám chuyên khoa nhi Bác sĩ Nguyễn Văn Lộc", "69/19 Lạc Trung, Vĩnh Tuy, Hai Bà Trưng, Hà Nội", 21.001, 105.86304, "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_180639.9265160000.jpeg"],
    [ "Phòng khám Chuyên khoa Nhi - 78 Quang Trung", "78 Quang Trung, Quang Trung, Hà Đông, Hà Nội", 20.97021, 105.77475, "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_183142.3821990000.jpeg"],
    [ "Phòng khám Đa khoa Quốc tế International SOS Hà Nội - Cơ sở 3", "51 Xuân Diệu , Quảng An, Tây Hồ, Hà Nội", 21.063772, 105.82735, "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_192241.7740420000.jpeg"],
    [ "Phòng khám Đa khoa Quốc tế Vinmec - Sài Gòn", "2/2 Trần Cao Vân, Đa Kao, Quận 1, Hồ Chí Minh", 10.785587, 106.698578, "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-07_091110.4497050000.jpeg" ]
  ]

  clinic_list.each do |clinic|
    Clinic.create( name: clinic[0], address: clinic[1], latitude: clinic[2].to_f, longtitude: clinic[3].to_f, photos: clinic[4] )
  end
