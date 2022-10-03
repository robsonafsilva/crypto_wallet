require 'tty-spinner'
namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    # %x -> faz uma chamada a um comando do terminal   
    if Rails.env.development?
      
      show_spinner("Apagando DB...") {%x(rails db:drop)}
     
      show_spinner("Criando DB...") {%x(rails db:create)}   
      
      show_spinner("Migrando DB...") {%x(rails db:migrate)}
                 
      %x(rails dev:add_mining_type)

      %x(rails dev:add_coin)      
     
    else
      puts "Essa task é somente para ambiente desenvolvimento."
    end    
  end

  desc "Cadastra as moedas no banco"
  task add_coin: :environment do
    show_spinner("Cadastrando moedas...", "Processo finalizado") do   
        coins = [
          { 
            description: "Biticoin",
            acronym: "BTC",
            url_image: "https://currencyimg.bitcointrade.com.br/currency_images/frontend/Colored/btc.svg",
            mining_type: MiningType.find_by(acronym: 'PoW')
          },    
          {
            description: "Ethereum",
            acronym: "ETH",
            url_image: "https://currencyimg.bitcointrade.com.br/currency_images/frontend/Colored/eth.svg",
            mining_type: MiningType.all.sample
          },    
          {
            description: "Dash",
            acronym: "DASH",
            url_image: "https://s2.coinmarketcap.com/static/img/coins/64x64/131.png",
            mining_type: MiningType.all.sample            
          },
          {
            description: "Dogecoin",
            acronym: "DOGE",
            url_image: "https://s2.coinmarketcap.com/static/img/coins/64x64/74.png",
            mining_type: MiningType.all.sample
          },
          {
            description: "Cardano",
            acronym: "ADA",
            url_image: "https://s2.coinmarketcap.com/static/img/coins/64x64/2010.png",
            mining_type: MiningType.all.sample
          }
        ]    
        coins.each do |coin|
          sleep(1)  
          Coin.find_or_create_by!(coin)
        end
      end 
  end

  desc "Cadastar os tipos de mineração."
  task add_mining_type: :environment do
    show_spinner("Criando tipos de mineração...", "Processo finalizado!") do   
        mining_type = [
          {description: "Proof of Work", acronym: "PoW"},
          {description: "Proof of Steak", acronym: "PoS"},
          {description: "Proof of Concept", acronym: "PoC"}
        ]
        mining_type.each do |type|
          sleep(1)
          MiningType.find_or_create_by!(type)
        end
    end  
  end


  private
    def show_spinner(msg_star, msg_end="Concluído.")
      spinner = TTY::Spinner.new("[:spinner] #{msg_star}", format: :dots_2)
      spinner.auto_spin
      yield
      spinner.stop("(#{msg_end})")
    end
end
