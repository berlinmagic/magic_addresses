# encoding: utf-8

puts "MagicAddresses seed default countries"

magic_addresses_default_countries = {
  "AT"=>{
    :dial_code => "+43", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Rakousko"}, 
      {:locale=>"de", :name=>"Österreich"}, 
      {:locale=>"en", :name=>"Austria"}, 
      {:locale=>"es", :name=>"Austria"}, 
      {:locale=>"fr", :name=>"Autriche"}, 
      {:locale=>"it", :name=>"Austria"}, 
      {:locale=>"pl", :name=>"Austria"}, 
      {:locale=>"ru", :name=>"Австрия"}
    ], 
    :default_name => "Austria"
  }, 
  "BY"=>{
    :dial_code => "+375", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Bělorusko"}, 
      {:locale=>"de", :name=>"Weißrussland"}, 
      {:locale=>"en", :name=>"Belarus"}, 
      {:locale=>"es", :name=>"Bielorrusia"}, 
      {:locale=>"fr", :name=>"Bélarus"}, 
      {:locale=>"it", :name=>"Bielorussia"}, 
      {:locale=>"pl", :name=>"Białoruś"}, 
      {:locale=>"ru", :name=>"Беларусь"}
    ], 
    :default_name => "Belarus"
  }, 
  "BE"=>{
    :dial_code => "+32", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Belgie"}, 
      {:locale=>"de", :name=>"Belgien"}, 
      {:locale=>"en", :name=>"Belgium"}, 
      {:locale=>"es", :name=>"Bélgica"}, 
      {:locale=>"fr", :name=>"Belgique"}, 
      {:locale=>"it", :name=>"Belgio"}, 
      {:locale=>"pl", :name=>"Belgia"}, 
      {:locale=>"ru", :name=>"Бельгия"}
    ], 
    :default_name => "Belgium"
  }, 
  "BA"=>{
    :dial_code => "+387", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Bosna a Hercegovina"}, 
      {:locale=>"de", :name=>"Bosnien und Herzegowina"}, 
      {:locale=>"en", :name=>"Bosnia and Herzegovina"}, 
      {:locale=>"es", :name=>"Bosnia y Herzegovina"}, 
      {:locale=>"fr", :name=>"Bosnie-Herzégovine"}, 
      {:locale=>"it", :name=>"Bosnia-Erzegovina"}, 
      {:locale=>"pl", :name=>"Bośnia i Hercegowina"}, 
      {:locale=>"ru", :name=>"Босния и Герцеговина"}
    ], 
    :default_name => "Bosnia and Herzegovina"
  }, 
  "BG"=>{
    :dial_code => "+359", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Bulharsko"}, 
      {:locale=>"de", :name=>"Bulgarien"}, 
      {:locale=>"en", :name=>"Bulgaria"}, 
      {:locale=>"es", :name=>"Bulgaria"}, 
      {:locale=>"fr", :name=>"Bulgarie"}, 
      {:locale=>"it", :name=>"Bulgaria"}, 
      {:locale=>"pl", :name=>"Bułgaria"}, 
      {:locale=>"ru", :name=>"Болгария"}
    ], 
    :default_name => "Bulgaria"
  }, 
  "CA"=>{
    :dial_code => "+1", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Kanada"}, 
      {:locale=>"de", :name=>"Kanada"}, 
      {:locale=>"en", :name=>"Canada"}, 
      {:locale=>"es", :name=>"Canadá"}, 
      {:locale=>"fr", :name=>"Canada"}, 
      {:locale=>"it", :name=>"Canada"}, 
      {:locale=>"pl", :name=>"Kanada"}, 
      {:locale=>"ru", :name=>"Канада"}
    ], 
    :default_name => "Canada"
  }, 
  "HR"=>{
    :dial_code => "+385", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Chorvatsko"}, 
      {:locale=>"de", :name=>"Kroatien"}, 
      {:locale=>"en", :name=>"Croatia"}, 
      {:locale=>"es", :name=>"Croacia"}, 
      {:locale=>"fr", :name=>"Croatie"}, 
      {:locale=>"it", :name=>"Croazia"}, 
      {:locale=>"pl", :name=>"Chorwacja"}, 
      {:locale=>"ru", :name=>"Хорватия"}
    ], 
    :default_name => "Croatia"
  }, 
  "CY"=>{
    :dial_code => "+357", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Kypr"}, 
      {:locale=>"de", :name=>"Zypern"}, 
      {:locale=>"en", :name=>"Cyprus"}, 
      {:locale=>"es", :name=>"Chipre"}, 
      {:locale=>"fr", :name=>"Chypre"}, 
      {:locale=>"it", :name=>"Cipro"}, 
      {:locale=>"pl", :name=>"Cypr"}, 
      {:locale=>"ru", :name=>"Кипр"}
    ], 
    :default_name => "Cyprus"
  }, 
  "CZ"=>{
    :dial_code => "+420", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Česká republika"}, 
      {:locale=>"de", :name=>"Tschechische Republik"}, 
      {:locale=>"en", :name=>"Czech Republic"}, 
      {:locale=>"es", :name=>"República Checa"}, 
      {:locale=>"fr", :name=>"Tchèque, République"}, 
      {:locale=>"it", :name=>"Repubblica Ceca"}, 
      {:locale=>"pl", :name=>"Czechy"}, 
      {:locale=>"ru", :name=>"Чешская Республика"}
    ], 
    :default_name => "Czech Republic"
  }, 
  "DK"=>{
    :dial_code => "+45", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Dánsko"}, 
      {:locale=>"de", :name=>"Dänemark"}, 
      {:locale=>"en", :name=>"Denmark"}, 
      {:locale=>"es", :name=>"Dinamarca"}, 
      {:locale=>"fr", :name=>"Danemark"}, 
      {:locale=>"it", :name=>"Danimarca"}, 
      {:locale=>"pl", :name=>"Dania"}, 
      {:locale=>"ru", :name=>"Дания"}
    ], 
    :default_name => "Denmark"
  }, 
  "FI"=>{
    :dial_code => "+358", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Finsko"}, 
      {:locale=>"de", :name=>"Finnland"}, 
      {:locale=>"en", :name=>"Finland"}, 
      {:locale=>"es", :name=>"Finlandia"}, 
      {:locale=>"fr", :name=>"Finlande"}, 
      {:locale=>"it", :name=>"Finlandia"}, 
      {:locale=>"pl", :name=>"Finlandia"}, 
      {:locale=>"ru", :name=>"Финляндия"}
    ], 
    :default_name => "Finland"
  }, 
  "FR"=>{
    :dial_code => "+33", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Francie"}, 
      {:locale=>"de", :name=>"Frankreich"}, 
      {:locale=>"en", :name=>"France"}, 
      {:locale=>"es", :name=>"Francia"}, 
      {:locale=>"fr", :name=>"France"}, 
      {:locale=>"it", :name=>"Francia"}, 
      {:locale=>"pl", :name=>"Francja"}, 
      {:locale=>"ru", :name=>"Франция"}
    ], 
    :default_name => "France"
  }, 
  "DE"=>{
    :dial_code => "+49", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Německo"}, 
      {:locale=>"de", :name=>"Deutschland"}, 
      {:locale=>"en", :name=>"Germany"}, 
      {:locale=>"es", :name=>"Alemania"}, 
      {:locale=>"fr", :name=>"Allemagne"}, 
      {:locale=>"it", :name=>"Germania"}, 
      {:locale=>"pl", :name=>"Niemcy"}, 
      {:locale=>"ru", :name=>"Германия"}
    ], 
    :default_name => "Germany"
  }, 
  "GR"=>{
    :dial_code => "+30", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Řecko"}, 
      {:locale=>"de", :name=>"Griechenland"}, 
      {:locale=>"en", :name=>"Greece"}, 
      {:locale=>"es", :name=>"Grecia"}, 
      {:locale=>"fr", :name=>"Grèce"}, 
      {:locale=>"it", :name=>"Grecia"}, 
      {:locale=>"pl", :name=>"Grecja"}, 
      {:locale=>"ru", :name=>"Греция"}
    ], 
    :default_name => "Greece"
  }, 
  "HU"=>{
    :dial_code => "+36", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Maďarsko"}, 
      {:locale=>"de", :name=>"Ungarn"}, 
      {:locale=>"en", :name=>"Hungary"}, 
      {:locale=>"es", :name=>"Hungría"}, 
      {:locale=>"fr", :name=>"Hongrie"}, 
      {:locale=>"it", :name=>"Ungheria"}, 
      {:locale=>"pl", :name=>"Węgry"}, 
      {:locale=>"ru", :name=>"Венгрия"}
    ], 
    :default_name => "Hungary"
  }, 
  "IE"=>{
    :dial_code => "+353", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Irsko"}, 
      {:locale=>"de", :name=>"Irland"}, 
      {:locale=>"en", :name=>"Ireland"}, 
      {:locale=>"es", :name=>"Irlanda"}, 
      {:locale=>"fr", :name=>"Irlande"}, 
      {:locale=>"it", :name=>"Irlanda"}, 
      {:locale=>"pl", :name=>"Irlandia"}, 
      {:locale=>"ru", :name=>"Ирландия"}
    ], 
    :default_name => "Ireland"
  }, 
  "IT"=>{
    :dial_code => "+39", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Itálie"}, 
      {:locale=>"de", :name=>"Italien"}, 
      {:locale=>"en", :name=>"Italy"}, 
      {:locale=>"es", :name=>"Italia"}, 
      {:locale=>"fr", :name=>"Italie"}, 
      {:locale=>"it", :name=>"Italia"}, 
      {:locale=>"pl", :name=>"Włochy"}, 
      {:locale=>"ru", :name=>"Италия"}
    ], 
    :default_name => "Italy"
  }, 
  "LV"=>{
    :dial_code => "+371", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Lotyšsko"}, 
      {:locale=>"de", :name=>"Lettland"}, 
      {:locale=>"en", :name=>"Latvia"}, 
      {:locale=>"es", :name=>"Letonia"}, 
      {:locale=>"fr", :name=>"Lettonie"}, 
      {:locale=>"it", :name=>"Lettonia"}, 
      {:locale=>"pl", :name=>"Łotwa"}, 
      {:locale=>"ru", :name=>"Латвия"}
    ], 
    :default_name => "Latvia"
  }, 
  "LI"=>{
    :dial_code => "+423", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Lichtenštejnsko"}, 
      {:locale=>"de", :name=>"Liechtenstein"}, 
      {:locale=>"en", :name=>"Liechtenstein"}, 
      {:locale=>"es", :name=>"Liechtenstein"}, 
      {:locale=>"fr", :name=>"Liechtenstein"}, 
      {:locale=>"it", :name=>"Liechtenstein"}, 
      {:locale=>"pl", :name=>"Liechtenstein"}, 
      {:locale=>"ru", :name=>"Лихтенштейн"}
    ], 
    :default_name => "Liechtenstein"
  }, 
  "LT"=>{
    :dial_code => "+370", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Litva"}, 
      {:locale=>"de", :name=>"Litauen"}, 
      {:locale=>"en", :name=>"Lithuania"}, 
      {:locale=>"es", :name=>"Lituania"}, 
      {:locale=>"fr", :name=>"Lituanie"}, 
      {:locale=>"it", :name=>"Lituania"}, 
      {:locale=>"pl", :name=>"Litwa"}, 
      {:locale=>"ru", :name=>"Литва"}
    ], 
    :default_name => "Lithuania"
  }, 
  "LU"=>{
    :dial_code => "+352", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Lucembursko"}, 
      {:locale=>"de", :name=>"Luxemburg"}, 
      {:locale=>"en", :name=>"Luxembourg"}, 
      {:locale=>"es", :name=>"Luxemburgo"}, 
      {:locale=>"fr", :name=>"Luxembourg"}, 
      {:locale=>"it", :name=>"Lussemburgo"}, 
      {:locale=>"pl", :name=>"Luksemburg"}, 
      {:locale=>"ru", :name=>"Люксембург"}
    ], 
    :default_name => "Luxembourg"
  }, 
  "NL"=>{
    :dial_code => "+31", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Nizozemsko"}, 
      {:locale=>"de", :name=>"Niederlande"}, 
      {:locale=>"en", :name=>"Netherlands"}, 
      {:locale=>"es", :name=>"Países Bajos"}, 
      {:locale=>"fr", :name=>"Pays-Bas"}, 
      {:locale=>"it", :name=>"Paesi Bassi"}, 
      {:locale=>"pl", :name=>"Holandia"}, 
      {:locale=>"ru", :name=>"Нидерланды"}
    ], 
    :default_name => "Netherlands"
  }, 
  "NO"=>{
    :dial_code => "+47", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Norsko"}, 
      {:locale=>"de", :name=>"Norwegen"}, 
      {:locale=>"en", :name=>"Norway"}, 
      {:locale=>"es", :name=>"Noruega"}, 
      {:locale=>"fr", :name=>"Norvège"}, 
      {:locale=>"it", :name=>"Norvegia"}, 
      {:locale=>"pl", :name=>"Norwegia"}, 
      {:locale=>"ru", :name=>"Норвегия"}
    ], 
    :default_name => "Norway"
  }, 
  "PL"=>{
    :dial_code => "+48", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Polsko"}, 
      {:locale=>"de", :name=>"Polen"}, 
      {:locale=>"en", :name=>"Poland"}, 
      {:locale=>"es", :name=>"Polonia"}, 
      {:locale=>"fr", :name=>"Pologne"}, 
      {:locale=>"it", :name=>"Polonia"}, 
      {:locale=>"pl", :name=>"Polska"}, 
      {:locale=>"ru", :name=>"Польша"}
    ], 
    :default_name => "Poland"
  }, 
  "PT"=>{
    :dial_code => "+351", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Portugalsko"}, 
      {:locale=>"de", :name=>"Portugal"}, 
      {:locale=>"en", :name=>"Portugal"}, 
      {:locale=>"es", :name=>"Portugal"}, 
      {:locale=>"fr", :name=>"Portugal"}, 
      {:locale=>"it", :name=>"Portogallo"}, 
      {:locale=>"pl", :name=>"Portugalia"}, 
      {:locale=>"ru", :name=>"Португалия"}
    ], 
    :default_name => "Portugal"
  }, 
  "RO"=>{
    :dial_code => "+40", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Rumunsko"}, 
      {:locale=>"de", :name=>"Rumänien"}, 
      {:locale=>"en", :name=>"Romania"}, 
      {:locale=>"es", :name=>"Rumanía"}, 
      {:locale=>"fr", :name=>"Roumanie"}, 
      {:locale=>"it", :name=>"Romania"}, 
      {:locale=>"pl", :name=>"Rumunia"}, 
      {:locale=>"ru", :name=>"Румыния"}
    ], 
    :default_name => "Romania"
  }, 
  "RU"=>{
    :dial_code => "+7", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Ruská federace"}, 
      {:locale=>"de", :name=>"Russische Föderation"}, 
      {:locale=>"en", :name=>"Russian Federation"}, 
      {:locale=>"es", :name=>"Federación Rusa"}, 
      {:locale=>"fr", :name=>"Russie, Fédération de"}, 
      {:locale=>"it", :name=>"Russia"}, 
      {:locale=>"pl", :name=>"Federacja Rosyjska"}, 
      {:locale=>"ru", :name=>"Российская Федерация"}
    ], 
    :default_name => "Russian Federation"
  }, 
  "RS"=>{
    :dial_code => "+381", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Srbsko"}, 
      {:locale=>"de", :name=>"Serbien"}, 
      {:locale=>"en", :name=>"Serbia"}, 
      {:locale=>"es", :name=>"Serbia"}, 
      {:locale=>"fr", :name=>"Serbie"}, 
      {:locale=>"it", :name=>"Serbia"}, 
      {:locale=>"pl", :name=>"Serbia"}, 
      {:locale=>"ru", :name=>"Сербия"}
    ], 
    :default_name => "Serbia"
  }, 
  "SK"=>{
    :dial_code => "+421", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Slovensko"}, 
      {:locale=>"de", :name=>"Slowakei"}, 
      {:locale=>"en", :name=>"Slovakia"}, 
      {:locale=>"es", :name=>"Eslovaquia"}, 
      {:locale=>"fr", :name=>"Slovaquie"}, 
      {:locale=>"it", :name=>"Slovacchia"}, 
      {:locale=>"pl", :name=>"Słowacja"}, 
      {:locale=>"ru", :name=>"Словакия"}
    ], 
    :default_name => "Slovakia"
  }, 
  "SI"=>{
    :dial_code => "+386", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Slovinsko"}, 
      {:locale=>"de", :name=>"Slowenien"}, 
      {:locale=>"en", :name=>"Slovenia"}, 
      {:locale=>"es", :name=>"Eslovenia"}, 
      {:locale=>"fr", :name=>"Slovénie"}, 
      {:locale=>"it", :name=>"Slovenia"}, 
      {:locale=>"pl", :name=>"Słowenia"}, 
      {:locale=>"ru", :name=>"Словения"}
    ], 
    :default_name => "Slovenia"
  }, 
  "ES"=>{
    :dial_code => "+34", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Španělsko"}, 
      {:locale=>"de", :name=>"Spanien"}, 
      {:locale=>"en", :name=>"Spain"}, 
      {:locale=>"es", :name=>"España"}, 
      {:locale=>"fr", :name=>"Espagne"}, 
      {:locale=>"it", :name=>"Spagna"}, 
      {:locale=>"pl", :name=>"Hiszpania"}, 
      {:locale=>"ru", :name=>"Испания"}
    ], 
    :default_name => "Spain"
  }, 
  "SE"=>{
    :dial_code => "+46", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Švédsko"}, 
      {:locale=>"de", :name=>"Schweden"}, 
      {:locale=>"en", :name=>"Sweden"}, 
      {:locale=>"es", :name=>"Suecia"}, 
      {:locale=>"fr", :name=>"Suède"}, 
      {:locale=>"it", :name=>"Svezia"}, 
      {:locale=>"pl", :name=>"Szwecja"}, 
      {:locale=>"ru", :name=>"Швеция"}
    ], 
    :default_name => "Sweden"
  }, 
  "CH"=>{
    :dial_code => "+41", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Švýcarsko"}, 
      {:locale=>"de", :name=>"Schweiz"}, 
      {:locale=>"en", :name=>"Switzerland"}, 
      {:locale=>"es", :name=>"Suiza"}, 
      {:locale=>"fr", :name=>"Suisse"}, 
      {:locale=>"it", :name=>"Svizzera"}, 
      {:locale=>"pl", :name=>"Szwajcaria"}, 
      {:locale=>"ru", :name=>"Швейцария"}
    ], 
    :default_name => "Switzerland"
  }, 
  "UA"=>{
    :dial_code => "+380", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Ukrajina"}, 
      {:locale=>"de", :name=>"Ukraine"}, 
      {:locale=>"en", :name=>"Ukraine"}, 
      {:locale=>"es", :name=>"Ucrania"}, 
      {:locale=>"fr", :name=>"Ukraine"}, 
      {:locale=>"it", :name=>"Ucraina"}, 
      {:locale=>"pl", :name=>"Ukraina"}, 
      {:locale=>"ru", :name=>"Украина"}
    ], 
    :default_name => "Ukraine"
  }, 
  "GB"=>{
    :dial_code => "+44", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Spojené království"}, 
      {:locale=>"de", :name=>"Vereinigtes Königreich"}, 
      {:locale=>"en", :name=>"United Kingdom"}, 
      {:locale=>"es", :name=>"Reino Unido"}, 
      {:locale=>"fr", :name=>"Royaume-Uni"}, 
      {:locale=>"it", :name=>"Regno Unito"}, 
      {:locale=>"pl", :name=>"Wielka Brytania"}, 
      {:locale=>"ru", :name=>"Соединённое Королевство"}
    ], 
    :default_name => "United Kingdom"
  }, 
  "US"=>{
    :dial_code => "+1", 
    :translations_attributes => [
      {:locale=>"cs", :name=>"Spojené státy"}, 
      {:locale=>"de", :name=>"Vereinigte Staaten"}, 
      {:locale=>"en", :name=>"United States"}, 
      {:locale=>"es", :name=>"Estados Unidos"}, 
      {:locale=>"fr", :name=>"États-Unis"}, 
      {:locale=>"it", :name=>"Stati Uniti"}, 
      {:locale=>"pl", :name=>"Stany Zjednoczone"}, 
      {:locale=>"ru", :name=>"Соединённые штаты"}
    ], 
    :default_name => "United States"
  }
}

magic_addresses_default_countries.each do |key, params|
  puts " + #{params[:translations_attributes][2][:name]}"
  MagicAddresses::Country.create!( params.merge({ iso_code: key.to_s }) )
end

puts "MagicAddresses finished #{MagicAddresses::Country.all.count} countries"


