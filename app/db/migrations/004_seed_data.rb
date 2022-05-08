class SeedData < Sequel::Migration
  def up
    1..100.times do
      DB[:users].insert(username: Faker::Name.unique.name)
    end
    puts "Users done"
    ips = []
    1..50.times do
      ips.push(Faker::Internet.ip_v4_address)
    end

    (1..200000).each_slice(200) do
      DB[:posts].insert(author_ip: ips.sample,
                        title: Faker::Lorem.sentence,
                        content: Faker::Lorem.paragraph(sentence_count: 2),
                        user_id: DB[:users].select(:id).order(Sequel.lit('RANDOM()')).first[:id].to_i)
    end
    puts "Posts done"
    (1..10000).each_slice(200) do
      DB[:feedbacks].insert(model_id: DB[:posts].order(Sequel.lit('RANDOM()')).first[:id],
                            model_type: 'post',
                            comment: Faker::Lorem.paragraph(sentence_count: 2),
                            owner_id: DB[:users].order(Sequel.lit('RANDOM()')).first[:id])
    end
    puts "Posts feedbacks done"
    1..50.times do
      DB[:feedbacks].insert(model_id: DB[:users].order(Sequel.lit('RANDOM()')).first[:id],
                            model_type: 'user',
                            comment: Faker::Lorem.paragraph(sentence_count: 2),
                            owner_id: DB[:users].order(Sequel.lit('RANDOM()')).first[:id])
    end
    puts "User feedbacks done"
  end
end