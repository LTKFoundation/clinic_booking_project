# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  clinic_list = [
    [ "Phòng khám Đa khoa Medelab", "86-88 Nguyễn Lương Bằng, Quang Trung, Đống Đa, Hà Nội", "21.018516", "105.842071", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-11_020720.3832380000.jpeg"],
    [ "Phòng khám Đa khoa Quốc tế, International SOS Hồ Chí Minh - Cơ sở 2", "10.78378", "106.69003", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-02_071914.4940130000.jpeg" ],
    [ "Phòng khám Đa khoa Quốc Tế VietSing", "21.025371", "105.843433", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_182933.2461330000.jpeg" ],
    [ "Phòng khám Đa khoa Quốc Tế VietSing", "21.025371", "105.843433", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_182933.2461330000.jpeg" ],
    [ "Phòng khám Vietlife MRI", "14 Trần Bình Trọng", "21.020742", "105.844517", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-12_043002.6635410000.jpeg" ]
  ]

  clinic_list.each do |clinic|
    Clinic.create( name: clinic[0], address: clinic[1], latitude: clinic[2], longtitude: clinic[3], photos: clinic[4] )
  end

