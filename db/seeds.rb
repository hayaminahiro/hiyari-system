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
20.times do
  Senior.create!(facility_id: 1,
                 senior_name: "2F-利用者-#{a += 1}",
                 floor: 2,
                 using_flg: true
                 )
end

#3F施設利用者
a = 0
20.times do
  Senior.create!(facility_id: 1,
                 senior_name: "3F-利用者-#{a += 1}",
                 floor:3,
                 using_flg: true
  )
end

#4F施設利用者
a = 0
10.times do
  Senior.create!(facility_id: 1,
                 senior_name: "4F-利用者-#{a += 1}",
                 floor: 4,
                 using_flg: true
  )
end

#2F退所利用者
a = 0
10.times do
  Senior.create!(facility_id: 1,
                 senior_name: "2F-退所利用者-#{a += 1}",
                 floor: 2,
                 using_flg: false
  )
end

#3F退所利用者
a = 0
10.times do
  Senior.create!(facility_id: 1,
                 senior_name: "3F-退所利用者-#{a += 1}",
                 floor: 3,
                 using_flg: false
  )
end

#4F退所利用者
a = 0
5.times do
  Senior.create!(facility_id: 1,
                 senior_name: "4F-退所利用者-#{a += 1}",
                 floor: 4,
                 using_flg: false
  )
end

#=================================

#2F職員
a = 0
b = 0
10.times do
  Worker.create!(facility_id: 1,
                 worker_name: "2F-介護職員-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 2,
                 working_flg: true
  )
end

#3F職員
a = 0
b = 0
10.times do
  Worker.create!(facility_id: 1,
                 worker_name: "3F-介護職員-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 3,
                 working_flg: true
  )
end

#4F職員
a = 0
b = 0
5.times do
  Worker.create!(facility_id: 1,
                 worker_name: "4F-介護職員-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 4,
                 working_flg: true
  )
end

#2F退職職員
a = 0
b = 0
5.times do
  Worker.create!(facility_id: 1,
                 worker_name: "2F-退職介護職員-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 2,
                 working_flg: false
  )
end

#3F退職職員
a = 0
b = 0
5.times do
  Worker.create!(facility_id: 1,
                 worker_name: "3F-退職介護職員-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 3,
                 working_flg: false
  )
end

#4F退職職員
a = 0
b = 0
5.times do
  Worker.create!(facility_id: 1,
                 worker_name: "4F-退職介護職員-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 4,
                 working_flg: false
  )
end