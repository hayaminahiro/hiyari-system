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

#2F施設利用者
a = 0
b = 0
50.times do
  Senior.create!(facility_id: 1,
                 senior_name: "2F-SeniorUser-#{a += 1}",
                 floor: "2階",
                 charge_worker: "2F-SampleWorker-#{b += 1}",
                 using_flg: true
                 )
end

#3F施設利用者
a = 0
b = 0
50.times do
  Senior.create!(facility_id: 1,
                 senior_name: "3F-SeniorUser-#{a += 1}",
                 floor: "3階",
                 charge_worker: "3F-SampleWorker-#{b += 1}",
                 using_flg: true
  )
end

#4F施設利用者
a = 0
b = 0
25.times do
  Senior.create!(facility_id: 1,
                 senior_name: "4F-SeniorUser-#{a += 1}",
                 floor: "4階",
                 charge_worker: "4F-SampleWorker-#{b += 1}",
                 using_flg: true
  )
end

#2F退所利用者
a = 0
b = 0
40.times do
  Senior.create!(facility_id: 1,
                 senior_name: "2F-OFF-SeniorUser-#{a += 1}",
                 floor: "2階",
                 charge_worker: "2F-SampleWorker-#{b += 1}",
                 using_flg: false
  )
end

#3F退所利用者
a = 0
b = 0
40.times do
  Senior.create!(facility_id: 1,
                 senior_name: "3F-OFF-SeniorUser-#{a += 1}",
                 floor: "3階",
                 charge_worker: "3F-SampleWorker-#{b += 1}",
                 using_flg: false
  )
end

#4F退所利用者
a = 0
b = 0
30.times do
  Senior.create!(facility_id: 1,
                 senior_name: "4F-OFF-SeniorUser-#{a += 1}",
                 floor: "4階",
                 charge_worker: "4F-SampleWorker-#{b += 1}",
                 using_flg: false
  )
end