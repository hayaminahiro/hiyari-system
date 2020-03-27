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

#2F-Seniorに紐づくヒヤリ・事故作成
a = 0
20.times do
  Accident.create!(senior_id: a += 1,
                   which_accident: "事故",
                   accident_datetime: "2020-05-28 22:30:00",
                   accident_scene: "2F-ヒヤリ・事故の内容記載、エピソード"
  )
end

#3F-Seniorに紐づくヒヤリ・事故作成
a = 19
20.times do
  Accident.create!(senior_id: a += 1,
                   which_accident: "ヒヤリ",
                   accident_datetime: "2020-06-28 22:30:00",
                   accident_scene: "3F-ヒヤリ・事故の内容記載、エピソード"
  )
end

#4F-Seniorに紐づくヒヤリ・事故作成
a = 39
10.times do
  Accident.create!(senior_id: a += 1,
                   which_accident: "事故",
                   accident_datetime: "2020-02-28 22:30:00",
                   accident_scene: "4F-ヒヤリ・事故の内容記載、エピソード"
  )
end

#ヒヤリ・事故報告書サンプル 3月分
Accident.create!(senior_id: 1,
                 which_accident: "ヒヤリハット",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-03-31 22:30:00",
                 accident_senior: "井上権左衛門",
                 accident_scene: "ベッドから車椅子移乗時、頭から転落"
)

Accident.create!(senior_id: 1,
                 which_accident: "事故",
                 reporter: "井上良子",
                 accident_datetime: "2020-03-31 22:30:00",
                 accident_senior: "加藤恵美子",
                 accident_scene: "廊下で歩行中に転倒、左大腿部骨折"
)

#ヒヤリ・事故報告書サンプル 4月分
Accident.create!(senior_id: 1,
                 which_accident: "ヒヤリハット",
                 reporter: "大野元治",
                 accident_datetime: "2020-04-30 22:30:00",
                 accident_senior: "佐藤金太郎",
                 accident_scene: "飾り物の柿を口の中に入れてしまう"
)

Accident.create!(senior_id: 1,
                 which_accident: "ヒヤリハット",
                 reporter: "大野元治",
                 accident_datetime: "2020-04-30 22:30:00",
                 accident_senior: "佐藤金太郎",
                 accident_scene: "利用者Cの食事を横から食べてしまう"
)

Accident.create!(senior_id: 1,
                 which_accident: "事故",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-04-30 22:30:00",
                 accident_senior: "飯島寒子",
                 accident_scene: "利用者Bの眼鏡を取り上げ破壊してしまう"
)

#ヒヤリ・事故報告書サンプル 5月分
Accident.create!(senior_id: 1,
                 which_accident: "ヒヤリハット",
                 reporter: "大野元治",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_senior: "佐藤金太郎",
                 accident_scene: "折り紙を口の中に入れてしまう"
)

Accident.create!(senior_id: 1,
                 which_accident: "事故",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_senior: "佐野律子",
                 accident_scene: "食事中突然立ち上がり転倒"
)

Accident.create!(senior_id: 1,
                 which_accident: "事故",
                 reporter: "高橋敦子",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_senior: "鮫島正",
                 accident_scene: "薬が落ちているのを発見"
)