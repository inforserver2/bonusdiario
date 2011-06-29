#encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

countries=YAML::load_file("#{Rails.root.to_s}/db/countries.yml")
banks=YAML::load_file("#{Rails.root.to_s}/db/banks.yml")
bank_account_types=YAML::load_file("#{Rails.root.to_s}/db/bank_account_types.yml")

countries.each {|x| Country.find_or_create_by_id(x)}
banks.each {|x| Bank.find_or_create_by_id(x)}
bank_account_types.each {|x| BankAccountType.find_or_create_by_id(x)}

#Service.find_or_create_by_id(:id=>1, :name=>"Ciclo 1", :price=>50)
Service.find_or_create_by_id(:id=>1, :name=>"Empreendedor VIP", :price=>50)
#Service.find_or_create_by_id(:id=>2, :name=>"Ciclo 2", :price=>100)
#Service.find_or_create_by_id(:id=>3, :name=>"Ciclo 3", :price=>250)
#Service.find_or_create_by_id(:id=>4, :name=>"Ciclo 4", :price=>500)
#Service.find_or_create_by_id(:id=>5, :name=>"Ciclo 5", :price=>1000)
#Service.find_or_create_by_id(:id=>6, :name=>"Empreendedor VIP", :price=>50)

CommType.find_or_create_by_id(:id=>1, :payplan_id=>2, :name=>"Ciclo", :porcentage=>0.50)
#CommType.find_or_create_by_id(:id=>2, :payplan_id=>2, :name=>"Ciclo 2", :porcentage=>1)
#CommType.find_or_create_by_id(:id=>3, :payplan_id=>2, :name=>"Ciclo 3", :porcentage=>1)
#CommType.find_or_create_by_id(:id=>4, :payplan_id=>2, :name=>"Ciclo 4", :porcentage=>1)
#CommType.find_or_create_by_id(:id=>5, :payplan_id=>2, :name=>"Ciclo 5", :porcentage=>1)

CommType.find_or_create_by_id(:id=>6, :payplan_id=>1 ,:name=>"Nivel 1", :porcentage=>0.25)
CommType.find_or_create_by_id(:id=>7, :payplan_id=>1 ,:name=>"Nivel 2", :porcentage=>0.15)
CommType.find_or_create_by_id(:id=>8, :payplan_id=>1 ,:name=>"Nivel 3", :porcentage=>0.05)
CommType.find_or_create_by_id(:id=>9, :payplan_id=>1 ,:name=>"Nivel 4", :porcentage=>0.03)
CommType.find_or_create_by_id(:id=>10, :payplan_id=>1 ,:name=>"Nivel 5", :porcentage=>0.02)

Gender.find_or_create_by_id(:id=>1, :name=>"Masculino")
Gender.find_or_create_by_id(:id=>2, :name=>"Feminino")

Payplan.find_or_create_by_id(:id=>1, :name=>"Matriz")
Payplan.find_or_create_by_id(:id=>2, :name=>"Ciclo")

Bill.connection.execute "ALTER TABLE bills AUTO_INCREMENT=#{CFG['billing_auto_increment']};" unless Bill.any?

User.find_or_create_by_id(:id=>1,:name=>'www',:nick=>"Humberto",:fullname=>"Humberto Ribeiro", :password=>CFG['fakepass'], :email1=>CFG['fakemail'], :sponsor_id=>1, :avatar=>File.open("#{Rails.root}/app/assets/images/fakers/humberto_ribeiro.jpg"),:admin=>true,:close=>true, :money=>true, :comm=>true, :mail=>false)
User.find_or_create_by_id(:id=>2,:name=>'alinesouza',:nick=>"Aline Souza",:fullname=>"Aline Souza", :password=>CFG['fakepass'], :email1=>CFG['fakemail'], :sponsor_id=>1, :avatar=>File.open("#{Rails.root}/app/assets/images/fakers/aline_souza.jpg"),:close=>true, :money=>true, :comm=>true, :mail=>false)
User.find_or_create_by_id(:id=>3,:name=>'carlossan',:nick=>"Carlos San",:fullname=>"Carlos San", :password=>CFG['fakepass'], :email1=>CFG['fakemail'], :sponsor_id=>1, :avatar=>File.open("#{Rails.root}/app/assets/images/fakers/carlos_san.jpg"),:close=>true, :money=>true, :comm=>true, :mail=>false)
User.find_or_create_by_id(:id=>4,:name=>'cristianoalemao',:nick=>"Cristiano Alemão",:fullname=>"Cristiano Alemão", :password=>CFG['fakepass'], :email1=>CFG['fakemail'], :sponsor_id=>1, :avatar=>File.open("#{Rails.root}/app/assets/images/fakers/cristiano_alemao.jpg"),:close=>true, :money=>true, :comm=>true, :mail=>false)
User.find_or_create_by_id(:id=>5,:name=>'josegarra',:nick=>"José Garra",:fullname=>"José Garra", :password=>CFG['fakepass'], :email1=>CFG['fakemail'], :sponsor_id=>1, :avatar=>File.open("#{Rails.root}/app/assets/images/fakers/jose_garra.jpg"),:close=>true, :money=>true, :comm=>true, :mail=>false)
User.find_or_create_by_id(:id=>6,:name=>'mariahelena',:nick=>"Maria Helena",:fullname=>"Maria Helena", :password=>CFG['fakepass'], :email1=>CFG['fakemail'], :sponsor_id=>1, :avatar=>File.open("#{Rails.root}/app/assets/images/fakers/maria_helena.jpg"),:close=>true, :money=>true, :comm=>true, :mail=>false)
User.find_or_create_by_id(:id=>7,:name=>'oportunidade',:nick=>"Reinaldo Tavares",:fullname=>"Reinaldo Tavares", :password=>CFG['fakepass'], :email1=>CFG['fakemail'], :sponsor_id=>1, :avatar=>File.open("#{Rails.root}/app/assets/images/fakers/reinaldo_tavares.gif"),:close=>true, :money=>true, :comm=>true, :mail=>false)
User.find_or_create_by_id(:id=>8,:name=>'victor',:nick=>"Victor Teixeira",:fullname=>"Victor Teixeira", :password=>CFG['fakepass'], :email1=>CFG['fakemail'], :sponsor_id=>7, :avatar=>File.open("#{Rails.root}/app/assets/images/fakers/victor_teixeira.jpg"),:close=>true, :money=>true, :comm=>true, :mail=>false)
