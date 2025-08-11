# Usa uma imagem base oficial do Ruby
FROM ruby:3.2.2

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Instala dependências do sistema necessárias para o pg gem
RUN apt-get update && apt-get install -y postgresql-client build-essential

# Copia o Gemfile e o Gemfile.lock
COPY Gemfile .
COPY Gemfile.lock .

# Instala as gems
RUN bundle install

# Copia todo o restante do código da sua aplicação para o container
COPY . .

# Expõe a porta que o Puma (o servidor web padrão do Rails) irá usar
EXPOSE 3000

# Define o comando de inicialização da sua aplicação
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]