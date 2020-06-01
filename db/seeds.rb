#システム利用施設作成

Facility.create!(name:  "社会福祉法人くろねこ協会",
                 email: "admin_cat@email.com",
                 password:              "password",
                 password_confirmation: "password",
                 admin: true
)

# Sampleで多数のデータ投入
Facility.create!(name:  "社会福祉法人うみの風",
                 email: "center@email.com",
                 password:              "password",
                 password_confirmation: "password",
)

Facility.create!(name:  "特別養護老人ホーム ねこの街",
                 email: "cat@email.com",
                 password:              "password",
                 password_confirmation: "password")

#=================================

#2F施設利用者
a = 0
20.times do
  Senior.create!(facility_id: 2,
                 senior_name: "2F-利用者-#{a += 1}",
                 floor: 2,
                 using_flg: true
                 )
end

#3F施設利用者
a = 0
20.times do
  Senior.create!(facility_id: 2,
                 senior_name: "3F-利用者-#{a += 1}",
                 floor:3,
                 using_flg: true
  )
end

#4F施設利用者
a = 0
10.times do
  Senior.create!(facility_id: 2,
                 senior_name: "4F-利用者-#{a += 1}",
                 floor: 4,
                 using_flg: true
  )
end

#2F退所利用者
a = 0
10.times do
  Senior.create!(facility_id: 2,
                 senior_name: "2F-退所利用者-#{a += 1}",
                 floor: 2,
                 using_flg: false
  )
end

#3F退所利用者
a = 0
10.times do
  Senior.create!(facility_id: 2,
                 senior_name: "3F-退所利用者-#{a += 1}",
                 floor: 3,
                 using_flg: false
  )
end

#4F退所利用者
a = 0
5.times do
  Senior.create!(facility_id: 2,
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
  Worker.create!(facility_id: 2,
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
  Worker.create!(facility_id: 2,
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
  Worker.create!(facility_id: 2,
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
  Worker.create!(facility_id: 2,
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
  Worker.create!(facility_id: 2,
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
  Worker.create!(facility_id: 2,
                 worker_name: "4F-退職介護職員-#{a += 1}",
                 sign_name: "サイン-#{b += 1}",
                 working_floor: 4,
                 working_flg: false
  )
end

#=================================

#2Fヒヤリ・事故報告書サンプル 3月分
Accident.create!(senior_id: 1,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-03-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "井上権左衛門",
                 accident_floor: 2,
                 accident_scene: "ベッドから車椅子移乗時、頭から転落",
                 event_classification: 0,
                 activity_scene: 1
)

Accident.create!(senior_id: 2,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "井上良子",
                 accident_datetime: "2020-03-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "加藤恵美子",
                 accident_floor: 2,
                 accident_scene: "廊下で歩行中に転倒、左大腿部骨折",
                 event_classification: 0,
                 activity_scene: 1
)

#ヒヤリ・事故報告書サンプル 4月分
Accident.create!(senior_id: 3,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-04-30 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "佐藤金太郎",
                 accident_floor: 2,
                 accident_scene: "飾り物の柿を口の中に入れてしまう",
                 event_classification: 2,
                 activity_scene: 1
)

Accident.create!(senior_id: 7,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-04-30 09:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "佐藤金太郎",
                 accident_floor: 2,
                 accident_scene: "利用者Cの食事を横から食べてしまう",
                 event_classification: 2,
                 activity_scene: 2
)

Accident.create!(senior_id: 7,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-04-30 05:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "飯島寒子",
                 accident_floor: 2,
                 accident_scene: "利用者Bの眼鏡を取り上げ破壊してしまう",
                 event_classification: 4,
                 activity_scene: 1
)

#ヒヤリ・事故報告書サンプル 5月分
Accident.create!(senior_id: 7,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-05-31 20:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "佐藤金太郎",
                 accident_floor: 2,
                 accident_scene: "折り紙を口の中に入れてしまう",
                 event_classification: 2,
                 activity_scene: 1
)

Accident.create!(senior_id: 7,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "佐野律子",
                 accident_floor: 2,
                 accident_scene: "食事中突然立ち上がり転倒",
                 event_classification: 0,
                 activity_scene: 2
)

Accident.create!(senior_id: 2,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "高橋敦子",
                 accident_datetime: "2020-05-31 09:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "鮫島正",
                 accident_floor: 2,
                 accident_scene: "薬が落ちているのを発見",
                 event_classification: 3,
                 activity_scene: 3
)

#=================================

#3Fヒヤリ・事故報告書サンプル 3月分
Accident.create!(senior_id: 21,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-03-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "マイケル",
                 accident_floor: 3,
                 accident_scene: "ベッドから車椅子移乗時、頭から転落",
                 event_classification: 0,
                 activity_scene: 1
)

Accident.create!(senior_id: 21,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "井上良子",
                 accident_datetime: "2020-03-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "ジェニファー",
                 accident_floor: 3,
                 accident_scene: "廊下で歩行中に転倒、左大腿部骨折",
                 event_classification: 0,
                 activity_scene: 1
)

Accident.create!(senior_id: 22,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-03-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "マイケル",
                 accident_floor: 3,
                 accident_scene: "ベッドから車椅子移乗時、頭から転落ー2回目",
                 event_classification: 0,
                 activity_scene: 1
)

Accident.create!(senior_id: 23,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "井上良子",
                 accident_datetime: "2020-03-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "ジェニファー",
                 accident_floor: 3,
                 accident_scene: "廊下で歩行中に転倒、右大腿部骨折ー2回目",
                 event_classification: 0,
                 activity_scene: 1
)

#ヒヤリ・事故報告書サンプル 4月分
Accident.create!(senior_id: 22,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-04-30 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "ケン",
                 accident_floor: 3,
                 accident_scene: "偽物の柿を口の中に入れてしまう",
                 event_classification: 2,
                 activity_scene: 2
)

Accident.create!(senior_id: 24,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-04-30 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "マイク",
                 accident_floor: 3,
                 accident_scene: "利用者Cの髪の毛を食べてしまう",
                 event_classification: 4,
                 activity_scene: 5
)

Accident.create!(senior_id: 24,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-04-30 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "マイケル",
                 accident_floor: 3,
                 accident_scene: "利用者Bのお金を取り上げてしまう",
                 event_classification: 4,
                 activity_scene: 1
)

#ヒヤリ・事故報告書サンプル 5月分
Accident.create!(senior_id: 25,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "ジョー",
                 accident_floor: 3,
                 accident_scene: "折り紙を口の中に入れてしまう",
                 event_classification: 2,
                 activity_scene: 0
)

Accident.create!(senior_id: 25,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "ステファニー",
                 accident_floor: 3,
                 accident_scene: "食事中突然立ち上がり転倒",
                 event_classification: 0,
                 activity_scene: 2
)

Accident.create!(senior_id: 25,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "高橋敦子",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "ファントム",
                 accident_floor: 3,
                 accident_scene: "薬が落ちているのを発見",
                 event_classification: 3,
                 activity_scene: 4
)

Accident.create!(senior_id: 26,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "ジョー",
                 accident_floor: 3,
                 accident_scene: "折り紙を口の中に入れてしまう",
                 event_classification: 2,
                 activity_scene: 5
)

Accident.create!(senior_id: 26,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "ステファニー",
                 accident_floor: 3,
                 accident_scene: "食事中突然立ち上がり転倒",
                 event_classification: 0,
                 activity_scene: 2
)

Accident.create!(senior_id: 28,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "高橋敦子",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "ファントム",
                 accident_floor: 3,
                 accident_scene: "薬が落ちているのを発見",
                 event_classification: 3,
                 activity_scene: 0
)

#=================================

#4Fヒヤリ・事故報告書サンプル 3月分
Accident.create!(senior_id: 41,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-03-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "マイケル",
                 accident_floor: 4,
                 accident_scene: "ベッドから車椅子移乗時、頭から転落",
                 event_classification: 0,
                 activity_scene: 1
)

Accident.create!(senior_id: 42,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "井上良子",
                 accident_datetime: "2020-03-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "ジェニファー",
                 accident_floor: 4,
                 accident_scene: "廊下で歩行中に転倒、左大腿部骨折",
                 event_classification: 0,
                 activity_scene: 1
)

Accident.create!(senior_id: 44,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-03-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "マイケル",
                 accident_floor: 4,
                 accident_scene: "ベッドから車椅子移乗時、頭から転落ー2回目",
                 event_classification: 0,
                 activity_scene: 1
)

Accident.create!(senior_id: 44,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "井上良子",
                 accident_datetime: "2020-03-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "ジェニファー",
                 accident_floor: 4,
                 accident_scene: "廊下で歩行中に転倒、右大腿部骨折ー2回目",
                 event_classification: 0,
                 activity_scene: 1
)

#ヒヤリ・事故報告書サンプル 4月分
Accident.create!(senior_id: 49,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-04-30 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "ken",
                 accident_floor: 4,
                 accident_scene: "偽物の柿を口の中に入れてしまう",
                 event_classification: 2,
                 activity_scene: 2
)

Accident.create!(senior_id: 49,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-04-30 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "mike",
                 accident_floor: 4,
                 accident_scene: "利用者Cの髪の毛を食べてしまう",
                 event_classification: 4,
                 activity_scene: 3
)

Accident.create!(senior_id: 49,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-04-30 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "mikel",
                 accident_floor: 4,
                 accident_scene: "利用者Bのお金を取り上げてしまう",
                 event_classification: 4,
                 activity_scene: 5
)

#ヒヤリ・事故報告書サンプル 5月分
Accident.create!(senior_id: 47,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "jho",
                 accident_floor: 4,
                 accident_scene: "折り紙を口の中に入れてしまう",
                 event_classification: 2,
                 activity_scene: 1
)

Accident.create!(senior_id: 44,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "stave",
                 accident_floor: 4,
                 accident_scene: "食事中突然立ち上がり転倒",
                 event_classification: 0,
                 activity_scene: 2
)

Accident.create!(senior_id: 41,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "高橋敦子",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "fun",
                 accident_floor: 4,
                 accident_scene: "薬が落ちているのを発見",
                 event_classification: 3,
                 activity_scene: 4
)

Accident.create!(senior_id: 46,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "jon",
                 accident_floor: 4,
                 accident_scene: "折り紙を口の中に入れてしまう",
                 event_classification: 2,
                 activity_scene: 2
)

Accident.create!(senior_id: 41,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "齋藤隼人",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "step-boy",
                 accident_floor: 4,
                 accident_scene: "食事中突然立ち上がり転倒",
                 event_classification: 0,
                 activity_scene: 2
)

Accident.create!(senior_id: 48,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "高橋敦子",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "fancy",
                 accident_floor: 4,
                 accident_scene: "薬が落ちているのを発見",
                 event_classification: 3,
                 activity_scene: 5
)

Accident.create!(senior_id: 45,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "高橋敦子",
                 accident_datetime: "2020-05-31 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "mike",
                 accident_floor: 4,
                 accident_scene: "薬が落ちているのを発見",
                 event_classification: 3,
                 activity_scene: 0
)

#ヒヤリ・事故報告書サンプル 6月分
Accident.create!(senior_id: 46,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-06-15 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "jo",
                 accident_floor: 4,
                 accident_scene: "折り紙を口の中に入れてしまう",
                 event_classification: 2,
                 activity_scene: 5
)

Accident.create!(senior_id: 50,
                 facility_judge: 2,
                 which_accident: "事故",
                 department: "特養",
                 reporter: "高橋敦子",
                 accident_datetime: "2020-06-15 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "fun",
                 accident_floor: 4,
                 accident_scene: "薬が落ちているのを発見",
                 event_classification: 3,
                 activity_scene: 4
)

Accident.create!(senior_id: 50,
                 facility_judge: 2,
                 which_accident: "ヒヤリハット",
                 department: "特養",
                 reporter: "大野元治",
                 accident_datetime: "2020-06-15 22:30:00",
                 accident_time: "2020-03-31 22:30:00",
                 accident_senior: "jon",
                 accident_floor: 4,
                 accident_scene: "折り紙を口の中に入れてしまう",
                 event_classification: 2,
                 activity_scene: 0
)