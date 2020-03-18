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

#=================================

#2F施設利用者
a = 0
b = 0
50.times do
  Senior.create!(facility_id: 1,
                 senior_name: "2F-SeniorUser-#{a += 1}",
                 floor: 2,
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
                 floor:3,
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
                 floor: 4,
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
                 floor: 2,
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
                 floor: 3,
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
                 floor: 4,
                 charge_worker: "4F-SampleWorker-#{b += 1}",
                 using_flg: false
  )
end

#=================================

#2F職員
a = 0
b = 0
c = 0
20.times do
  Worker.create!(facility_id: 1,
                 worker_name: "2F-Worker-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 2,
                 charge_senior: "2F-ChargeSenior-#{c += 1}",
                 working_flg: true
  )
end

#3F職員
a = 0
b = 0
c = 0
20.times do
  Worker.create!(facility_id: 1,
                 worker_name: "3F-Worker-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 3,
                 charge_senior: "3F-ChargeSenior-#{c += 1}",
                 working_flg: true
  )
end

#4F職員
a = 0
b = 0
c = 0
10.times do
  Worker.create!(facility_id: 1,
                 worker_name: "4F-Worker-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 4,
                 charge_senior: "4F-ChargeSenior-#{c += 1}",
                 working_flg: true
  )
end

#2F退職職員
a = 0
b = 0
c = 0
25.times do
  Worker.create!(facility_id: 1,
                 worker_name: "2F-RetirementWorker-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 2,
                 charge_senior: "2F-ChargeSenior-#{c += 1}",
                 working_flg: false
  )
end

#3F退職職員
a = 0
b = 0
c = 0
25.times do
  Worker.create!(facility_id: 1,
                 worker_name: "3F-RetirementWorker-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 3,
                 charge_senior: "3F-ChargeSenior-#{c += 1}",
                 working_flg: false
  )
end

#4F退職職員
a = 0
b = 0
c = 0
15.times do
  Worker.create!(facility_id: 1,
                 worker_name: "4F-RetirementWorker-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 4,
                 charge_senior: "4F-ChargeSenior-#{c += 1}",
                 working_flg: false
  )
end