#システム利用施設作成
Facility.create!(name:  "社会福祉法人うみの風 本部",
             email: "center@email.com",
             password:              "password",
             password_confirmation: "password",
             admin: true
              )

Facility.create!(name:  "特別養護老人ホーム ねこの街",
             email: "cat@email.com",
             password:              "password",
             password_confirmation: "password")

#施設利用者作成
a = 0
b = 0
60.times do
  Senior.create!(facility_id: 1,
                 senior_name: "#{a += 1}鱗滝 左近時",
                 floor: "2階",
                 charge_worker: "#{b += 1}齋藤 隼人",
                 using_flg: true
                 )
end