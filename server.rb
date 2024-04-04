require 'shoes'


# start_rails.rb

# Define o caminho para a raiz do seu aplicativo Rails
RAILS_APP_PATH = '/home/vicente-simao/Dev/ruby_on_rails/venx2'

# Método para iniciar o servidor Rails
def start_rails_server
  # Navega até o diretório do aplicativo Rails
  Dir.chdir(RAILS_APP_PATH)

  # Inicia o servidor Rails e outras configurações importantes porta 3000
  system('rails db:create')
  system('rails db:migrate')
  system('rails db:seed')
  system('bundle exec whenever --clear-crontab')
  system("bundle exec whenever --update-crontab --set environment='development'")
  system('./bin/dev -p 3000')
end

# Chama o método para iniciar o servidor Rails
start_rails_server


