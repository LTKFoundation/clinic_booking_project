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
    [ "Phòng khám sản phụ khoa bác sĩ Đỗ Thị Ngọc Lan", "Số 26 ngõ 30 Nguyễn Đình Chiểu Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/11_07_2016_10_06_14_661256.jpeg", 21.014324, 105.846925],
    [ "Phòng khám bệnh số 1 - Bệnh viện Đại học Y Hà Nội", "1 Tôn Thất Tùng, Trung Tự, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-31_064426.2683230000.jpeg",21.001623, 105.829247 ],
    [ "Phòng khám Đa khoa Hoàng Long","Tầng 10 VCCI Tower, số 9, Đào Duy Anh, Phương Mai, Đống Đa, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_173717.9048930000.jpeg", 21.007574, 105.803581],
    [ "Phòng khám Phụ sản - Siêu âm - Sản phụ khoa - 110G3 Tập thể Trung Tự" , "110G3 Tập thể Trung Tự, Kim Liên, Đống Đa, Hà Nội ","https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_223021.6632780000.jpeg", 21.0104,105.83346],
    [ "Phòng khám Sản phụ khoa - Bác sĩ Đỗ Thị Vân", "9 ngõ 198 Xã Đàn, Phương Liên, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_234544.9058340000.jpeg", 21.01162,105.83752],
    [ "Phòng khám Tai Mũi Họng - Bác sĩ Dương Thanh Huyền", "115 Ngõ chợ Khâm Thiên, Trung Phụng, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_173613.2787460000.jpeg", 21.01667,105.8381],
    [ "Phòng khám Tai Mũi Họng - Bác sĩ Nguyễn Thị Thanh","87 Ngõ 218 chợ Khâm Thiên, Khâm Thiên, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_233725.3638480000.jpeg",21.01541,105.83666],
    [ "Phòng khám Tai Mũi Họng My Anh","362C Xã Đàn, Nam Đồng, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-18_092928.0989930000.jpeg", 21.01443,105.83453],
    [ "Phòng khám Đa khoa Medelab", "86-88 Nguyễn Lương Bằng, Quang Trung, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-11_020720.3832380000.jpeg", 21.018516, 105.842071 ],
    [ "Phòng khám,  Đa khoa Quốc Tế VietSing", "Pacific Place 83B Lý Thường Kiệt, Lý Thường Kiệt, Hoàn Kiếm, Hà Nội ",  "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_182933.2461330000.jpeg", 21.025371, 105.843433 ],
    [ "Phòng khám Vietlife MRI", "14 Trần Bình Trọng, Hai Bà Trưng, Hoàn Kiếm, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-12_043002.6635410000.jpeg", 21.020742, 105.844517 ],
    [ "Phòng Khám Đa khoa 70 Nguyễn Chí Thanh (VIETDOCTOR) - Cơ sở 1", "70 Nguyễn Chí Thanh, Láng Thượng, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2016-01-12_071554.5350500000.jpeg", 21.01867, 105.8073],
    [ "Phòng khám chuyên khoa nhi Bác sĩ Nguyễn Văn Lộc", "69/19 Lạc Trung, Vĩnh Tuy, Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_180639.9265160000.jpeg", 21.001, 105.86304],
    [ "Phòng khám Chuyên khoa Nhi - 78 Quang Trung", "78 Quang Trung, Quang Trung, Hà Đông, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_183142.3821990000.jpeg", 20.97021, 105.77475 ],
    [ "Phòng khám Đa khoa Quốc tế International SOS Hà Nội - Cơ sở 3", "51 Xuân Diệu , Quảng An, Tây Hồ, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_192241.7740420000.jpeg", 21.063772, 105.82735],
    [ "Phòng khám Đa khoa Quốc tế Vietclinic", "21 Nguyễn Công Hoan, Ngọc Khánh, Ba Đình, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/08_08_2016_00_50_59_555262.jpeg", 21.0273,105.81458],
    [ "Phòng khám Family Practice Medical - Cơ sở 3", "298 Kim Mã, khu ngoại giao đoàn Vạn Phúc, Kim Mã, Ba Đình, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-07_091637.9050110000.jpeg", 21.030418, 105.812407 ],
    [ "Phòng khám Nhi - Bác sĩ Dương Bá Trực", "B3- A4 Làng quốc tế Thăng Long, Trần Đăng Ninh, Dịch Vọng, Cầu Giấy, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_144450.6562040000.jpeg", 21.03976, 105.79197 ],
    [ "Phòng khám Nhi Đông Dương", "171/26 Nguyễn Hoàng Tôn, Xuân La, Tây Hồ, Hà Nội" ,"htt105.76496ps://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_205505.0077740000.jpeg", 21.07207, 105.80468 ],
    [ "Phòng khám Đa khoa Dr. Binh Tele Clinic", "11 - 13 - 15 Trần Xuân Soạn , Ngô Thì Nhậm, Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-23_032603.6016230000.jpeg", 21.017098,  105.854918],
    [ "Trung tâm Bác sĩ gia đình Hà Nội", "75 Hồ Mễ Trì, Trung Văn, Nam Từ Liêm, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_183311.5966610000.jpeg", 21.001018, 105.793297],
    [ "Phòng khám Nhi khoa - Bác sĩ Tú","129 Quan Hoa, Quan Hoa, Cầu Giấy, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_145359.8175180000.jpeg", 21.03453, 105.80394],
    [ "Phòng khám iMEDIC Lê Quý Đôn" , "10 Lê Qúy Đôn, Bạch Đằng, Hai Bà Trưng, Hà Nội",  "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_212226.7734180000.jpeg",21.01333,105.86215],
    [ "Phòng khám Đa khoa Thảo Ngọc", "400 Hồ Tùng Mậu, Cầu Diễn, Bắc Từ Liêm, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-18_023555.2398880000.jpeg",21.04076,105.764029],
    [ "Phòng khám Đa khoa 127 - 159A Lê Thanh Nghị", "159A Lê Thanh Nghị, Đồng Tâm, Hai Bà Trưng, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-11_022853.8053130000.jpeg", 21.010844,105.828209],
    [ "Phòng khám Nhi - Bác sỹ Nguyễn Văn Thường", "92 Đốc Ngữ, Vĩnh Phúc, Ba Đình, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_004005.6374860000.jpeg", 21.04131,105.81374],
    [ "Phòng khám Đa khoa Yecxanh", "221 Phố Vọng, Đồng Tâm, Hai Bà Trưng, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-03_051211.0138000000.jpeg",  20.996256,105.842956 ],
    [ "Phòng khám chuyên khoa Nhi Bác sĩ Đậu Việt Hùng", "55 phố 8/3 , Kim Ngưu, Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_175300.3670400000.jpeg", 20.99852,105.86024],
    [ "Phòng khám Đa khoa Quốc tế Việt - Nga Trung tâm bé khỏe Việt - Nga","36 Tuệ Tĩnh, Bùi Thị Xuân, Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-02_072928.6390350000.jpeg", 21.015383,105.850088 ],
    [ "Phòng khám Đa khoa Mỹ Đình", "C2/1/KĐT Mỹ Đình I, Mỹ Đình, Nam Từ Liêm, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_190543.7074170000.jpeg", 21.03234, 105.76496],
    [ "Phòng khám Nhi Tâm - Bác sĩ Thái Thiên Nam", "126 Trần Đại Nghĩa, Bách Khoa, Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_180119.7117650000.jpeg",20.99589,105.84546],
    [ "Phòng khám Đa khoa Tâm Thành", "161 Đặng Tiến Đông, Trung Liệt, Đống Đa, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-23_025235.6731360000.jpeg", 21.013338, 105.822571],
    [ "Phòng khám Tai Mũi Họng - Bác sĩ Nguyễn Thanh Thủy" , "F102 nhà B4 (số cũ căn hộ 35-B4) tập thể Trung Tự, Trung Tự, Đống Đa, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2016-01-05_043049.1817670000.jpeg",21.008868,105.834089],
    [ "Phòng khám Nội soi Tai Mũi Họng - Bác sĩ Đinh Thị Sinh" ,"21/12 Hồ Đắc Di, Nam Đồng, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_223235.4441120000.jpeg", 21.01226, 105.82917 ],
    [ "Phòng khám Đa khoa Việt Đức", "173 Lê Thanh Nghị, Đồng Tâm, Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_190326.3820140000.jpeg", 21.008921, 105.832393],
    [ "Phòng khám Đa khoa Nhân Ái", "709 Giải Phóng, Giáp Bát, Hoàng Mai, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-11_044400.3001410000.jpeg", 20.988174, 105.841236 ],
    [ "Phòng khám Chuyên khoa Nhi - Bác sĩ Nguyễn Thị Bảo" , "1/231 Khâm Thiên, Thổ Quan, Đống Đa, Hà Nội ", "", 21.019272,105.833464],
    [ "Phòng Khám Nhi Khoa Bác sĩ Thẩm Kim Dung", "160 Khâm Thiên, Khâm Thiên, Đống Đa, Hà Nội", "", 21.019112, 105.836298 ],
    [ "Phòng khám 387 - Bác sĩ Nguyễn Thị Thu Hoài", "387 Kim Mã, Ngọc Khánh, Ba Đình, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/14_11_2016_16_09_16_879055.jpeg", 21.030418,105.816085],
    [ "Phòng khám Đa Khoa 168 Hà Nội", "Km12 Ngọc Hồi , Tứ Hiệp, Thanh Trì, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/22_08_2016_04_08_19_789177.jpeg", 20.937455,105.845222],
    [ "Phòng khám 125 Thái Thịnh", "125 Thái Thịnh, Thái Quang, Đống Đa, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-05_020258.1575730000.jpeg", 21.011767, 105.817266], 
    [ "Phòng Khám theo yêu cầu - Bệnh viện Phụ sản Trung ương", "56 Hai Bà Trưng, Hàng Bông, Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/22_07_2016_06_42_35_977611.jpeg", 21.02609, 105.84648],
    [ "Phòng khám Sản phụ khoa - Bác sĩ  Tôn Nữ Tuyết Trinh" ,"P104 - G4 tập thể Thành Công, Thành Công, Ba Đình, Hà Nội", "", 21.021075, 105.815991],
    [ "Phòng khám Tai Mũi Họng - Bác sĩ Nguyễn Tuyết Mai", "44 ngõ 283 Trần Khát Chân, Thanh Nhàn, Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-23_080948.5975800000.jpeg", 21.009049, 105.857429],
    [ "Phòng khám Đa khoa Bình Minh", "103 Giải Phóng, Đồng Tâm, Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_183118.8313500000.jpeg", 21.002581, 105.841389], 
    [ "Phòng khám Sản phụ khoa Âu Lạc", "178 Lạc Long Quân, Bưởi , Tây Hồ, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_205311.2587890000.jpeg", 21.052597, 105.809238],
    [ "Phòng khám Sản Phụ khoa EVA - Cơ sở 1", "54 Trần Bình, Mai Dịch, Cầu Giấy, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_184657.9534700000.jpeg", 21.03482, 105.77876],
    [ "Phòng khám Đa khoa Thiên Tâm", "212 Nguyễn Lương Bằng, Quang Trung, Đống Đa, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-12_025449.3388980000.jpeg", 21.01481, 105.827662],
    [ "Phòng Khám 10A Hà Đông - Hoàng Gia Spa", "10A Khu đô thị Văn Quán, Phúc La, Hà Đông, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2016-03-04_074522.7513090000.jpeg", 21.16268, 105.852023],
    [ "Phòng Khám Sản Phụ khoa Chúc An", "Khu Village HuynDai 1, Tô Hiệu, Hà Đông, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_174347.8151980000.jpeg", 20.96584, 105.77593],
    [ "Phòng khám Bác sỹ Vỹ - Cơ sở 1", "89B Dốc Phụ Sản, La Thành, Ngọc Khánh, Ba Đình, Hà Nội ",  "https://dwbxi9io9o7ce.cloudfront.net/images/2016-03-02_071009.8892310000.jpeg", 21.031183, 105.806893],
    [ "Phòng khám Sản phụ khoa Hương Thủy", "77 Giải Phóng, Đồng Tâm, Hai Bà Trưng, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_185024.1421390000.jpeg", 21.00297, 105.84151],
    [ "Phòng khám chuyên khoa Sản phụ khoa Bác sĩ Nguyễn Thị Nhã", "198 - A1 Bạch Mai, Cầu Dền, Hai Bà Trưng, Hà Nội",  "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_172214.3206480000.jpeg", 21.0047, 105.85111],
    [ "Phòng khám Sản phụ khoa - Bác sĩ Nguyễn Duy Ánh", "21 Vạn Phúc, Liễu Giai, Ba Đình, Hà Nội", "", 21.034104, 105.823849],
    [ "Phòng khám Đa khoa Thái Hà", "11 Thái Hà , Trung Liệt, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-01_031528.4608510000.jpeg", 21.010664,  105.822244],
    [ "Phòng khám Sản phụ khoa - Nam khoa chất lượng cao 36 Ngô Quyền", "36 Ngô Quyền, Hàng Bài, Hoàn Kiếm, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/18_08_2016_00_51_36_616923.jpeg", 21.02329, 105.85467],
    [ "Phòng khám Nhi Đông Dương", "171/26 Nguyễn Hoàng Tôn, Xuân La, Tây Hồ, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_205505.0077740000.jpeg", 21.07207, 105.80468],
    [ "Phòng Khám chuyên khoa Tai - Mũi - Họng Đoàn Thị Hồng Hoa", "Số 11 Hai Bà Trưng, Tràng Tiền, Hoàn Kiếm, Hà Nội", "", 21.024888, 105.851826],
    [ "Phòng khám Đa khoa Phú Cường - Cơ sở 1", "615 Nguyễn Văn Cừ, Gia Thụy, Long Biên, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-01_043858.7629260000.jpeg", 21.052576, 105.885917],
    [ "Phòng khám Đa khoa Việt - Nhật", "Biệt thự 18 - BT5, khu đô thị Pháp Vân, Tứ Hiệp, Hoàng Mai, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-09_051042.8896360000.jpeg", 20.954389, 105.846295],
    [ "Phòng khám Sản phụ khoa Bác sĩ Nguyễn Minh Nguyệt",  "6 ngõ 23 Cát Linh, Cát Linh, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_184030.6395910000.jpeg", 21.02854, 105.83123],
    [ "Phòng khám Tai Mũi Họng - Bác sĩ Hoàng Đình Ngọc", "31/255 Phố Vọng, Đồng Tâm, Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_172554.4424950000.jpeg", 20.99497,105.8441],
    [ "Phòng khám Đa khoa 7A Quang Vinh", "185 Phùng Hưng, Phúc La, Hà Đông, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_173402.6942810000.jpeg",20.9687, 105.78591 ],
    [ "Phòng khám Sản khoa - Nội khoa - 93 Giải Phóng", "93 Giải Phóng, Đồng Tâm, Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_214309.1834550000.jpeg", 21.00269, 105.84146], 
    [ "Phòng khám Tai- Mũi- Họng- Bác sĩ Lê Anh Tuấn", "182 Nguyễn Sơn, Bồ Đề, Long Biên, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_215909.0508080000.jpeg", 21.04569, 105.88042 ],
    [ "Phòng khám Sản phụ khoa - Bác sĩ Cao Thị Hồng Chi", "2 Lê Đức Thọ, Mai Dịch, Cầu Giấy, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-17_021528.0288390000.jpeg", 21.035327, 105.771994],
    [ "Phòng khám chuyên khoa Phụ sản Bác sĩ Nguyễn Thị Ngọc Khanh", "Số 87 Nguyễn Du, Nguyễn Du, Hai Bà Trưng, Hà Nội ", 21.02049, 105.84183],
    [ "Phòng khám Đa khoa Đông Đô", "61 Phương Mai, Phương Mai, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-05_024348.7180270000.jpeg", 21.00385, 105.83741],
    [ "Phòng khám Hoa Hồng", "9 Dã Tượng, Trần Hưng Đạo, Hoàn Kiếm, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_171453.4713560000.jpeg", 21.023339, 105.846802],
    [ "Phòng khám Tai Mũi Họng 188 Hoàng Quốc Việt", "188 Hoàng Quốc Việt, Nghĩa Tân, Bắc Từ Liêm, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-18_013507.4013060000.jpeg",21.04621, 105.7901],
    [ "Trung tâm Tai Mũi Họng - Giáo sư Hòa", "105 Láng Hạ, Láng Hạ, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/02_08_2016_09_06_33_075495.jpeg", 21.013837, 105.81311], 
    [ "Phòng khám Siêu âm - Sản phụ khoa - Bác sĩ Khanh", "87- A2 khu A, Đô thị Đại Kim, Nguyễn Cảnh Dị, Đại Kim, Hoàng Mai, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-10_033657.9588110000.jpeg", 20.97663, 105.83519 ],
    [ "Phòng khám Đa khoa Mỹ Việt", "620 Hoàng Hoa Thám, Bưởi, Tây Hồ, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_170601.4747950000.jpeg", 21.04681, 105.80963 ],
    [ "Phòng khám Siêu âm Sản phụ khoa Bác sĩ Hiền Lương", "30 Ngõ 376 Vĩnh Hưng, Vĩnh Hưng, Hoàng Mai, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_035836.1366620000.jpeg", 20.99506, 105.88026],
    [ "Phòng khám Sản Phụ Khoa Phương Mai", "102 Nguyễn Du, Nguyễn Du, Hai Bà Trưng, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-27_190309.6116950000.jpeg", 21.02041, 105.84221 ],
    [ "Phòng khám nội soi Tai Mũi Họng - Bác sĩ Quách Thị Cần", "9 Đặng Tiến Đông, Trung Liệt, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_222333.8484420000.jpeg", 21.01183, 105.82413],
    [ "Phòng khám Sản phụ khoa Bác sĩ Trần Danh Cường", "12 Điện Biên Phủ, Điện Biên, Ba Đình, Hà Nội", "", 21.029271,105.842537 ],
    [ "Phòng khám Tai - Mũi - Họng Võ Thanh Quang", "27/198 Lê Trọng Tấn, Định Công, Hoàng Mai, Hà Nội ", "", 20.9931, 105.83041],
    [ "Phòng khám Sản phụ khoa - Bác sĩ Nguyễn Đức Thuấn", "50/255 Lĩnh Nam, Vĩnh Hưng, Hoàng Mai, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_031224.6332430000.jpeg", 20.98633, 105.87417 ],
    [ "Phòng khám Đa khoa Minh Ngọc", "517 Lạc Long Quân, Lạc Long Quân, Tây Hồ, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_205140.2714110000.jpeg", 21.06254, 105.80925 ],
    [ "Phòng khám Hữu nghị Việt Nam - Hàn quốc - Bệnh viện Xanh Pôn", "12 Chu Văn An, Điện Biên, Ba Đình, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2016-03-02_045116.5334130000.jpeg", 21.031253, 105.836102],
    [ "Phòng khám Tai Mũi Họng - Bác sĩ Lê Xuân Cành", "193 Minh Khai, Minh Khai, Hai Bà Trưng, Hà Nội ", "", 20.995722, 105.85919 ], 
    [ "Phòng khám Nhi - Tai Mũi Họng - Bác sĩ Huyền Trang", "86C ngõ 381 Nguyễn Khang, Yên Hòa, Cầu Giấy, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-05_020340.4795120000.jpeg", 20.9893077, 105.8004925 ],
    [ "Phòng khám Nhi - Tai Mũi Họng - Tòa nhà C'Land Lê Đức Thọ", "Tầng 1 tòa nhà C'Land Lê Đức Thọ, Mỹ Đình 2, Nam Từ Liêm, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_093434.7535270000.jpeg", 21.04377, 105.77551 ],
    [ "Phòng khám Đa khoa Khương Trung", "59 Khương Trung, Khương Trung, Thanh Xuân, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-28_013727.3153820000.jpeg", 20.999932, 105.818731 ],
    [ "Phòng khám bệnh Đa khoa 124 - Trung tâm y tế dự phòng quận Tây Hồ", "124 Hoàng Hoa Thám, Thụy Khê, Tây Hồ, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-17_033727.1937260000.jpeg", 21.045334, 105.830548 ],
    [ "Phòng khám Đa khoa Ngọc Khánh", "140 Chùa Láng, Láng Thượng, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_232451.2980930000.jpeg", 21.023583, 105.805378 ],
    [ "Phòng khám Đa khoa Định Công", "1A, Trần Nguyên Đán, KĐT Định Công , Định Công, Hoàng Mai, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_042257.2856960000.jpeg", 20.98506, 105.83371 ],
    [ "Phòng khám Sản phụ khoa - Bác sĩ Lưu Thị Hồng", "11 Thiền Quang, Nguyễn Du, Hai Bà Trưng, Hà Nội", "", 21.019564, 105.842668],
    [ "Phòng khám Siêu âm - Sản phụ khoa - 75 Sài Đồng", "75 Sài Đồng, Sài Đồng, Long Biên, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_221355.4909590000.jpeg", 21.03527, 105.91055], 
    [ "Phòng khám chuyên khoa Nhi - Bác sĩ Đào Minh Tuấn", "155B Đội Cấn, Đội Cấn, Ba Đình, Hà Nội", "", 21.035018, 105.824848 ],
    [ "Phòng khám Sản phụ khoa Tâm Đức", "8A Dốc viện phụ sản, Ngọc Khánh, Ba Đình, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_012947.1824300000.jpeg", 21.02696, 105.80948 ],
    [ "Phòng khám Tai Mũi Họng - Tương Mai", "4 K20 ngõ 63 Nguyễn An Ninh, Tương Mai, Hoàng Mai, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_021944.3828990000.jpeg",20.99029, 105.8449],
    [ "Phòng khám Đa khoa An Thịnh", "58 Trần Bình, Mai Dịch, Cầu Giấy, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-26_094840.8546390000.jpeg", 21.03464, 105.77876 ],
    [ "Phòng khám Sản phụ khoa Vạn Phúc", "23B Vạn Phúc, Vạn Phúc, Hà Đông, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_172110.1383990000.jpeg", 20.98134, 105.77137], 
    [ "Phòng khám chuyên khoa Nhi - Nhi Việt", "879 Đê La Thành , Láng Thượng, Đống Đa, Hà Nội", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-12-29_102110.5275280000.jpeg", 21.0249, 105.808532 ],
    [ "Phòng khám Sản phụ khoa - Bác sĩ Lê Thị Hiếu", "72 ngõ 49 Huỳnh Thúc Kháng , Láng Hạ, Đống Đa, Hà Nội", "", 21.015937, 105.809192 ],
    [ "Phòng khám Sản phụ khoa Phúc Diễn", "31 Phúc Diễn, Phúc Diễn, Bắc Từ Liêm, Hà Nội ", "https://dwbxi9io9o7ce.cloudfront.net/images/2015-11-25_191434.4654470000.jpeg", 21.04112, 105.76069],
    [ "Phòng khám Tai - Mũi - Họng Bác sĩ Nguyễn Tấn Quang", "264 Lê Thanh Nghị, Đồng Tâm, Hai Bà Trưng, Hà Nội", "", 21.00169, 105.84179 ],
    [ "Phòng khám Tai Mũi Họng - Bác sĩ Trần Tố Dung", "101/B10 Nghĩa Tân, Nghĩa Tân, Cầu Giấy, Hà Nội ", "", 21.0300175, 105.8015825], 
   ]

  clinic_list.each do |clinic|
    Clinic.create( name: clinic[0], address: clinic[1], photos: clinic[2], latitude: clinic[3].to_f, longtitude: clinic[4].to_f )
  end
