require 'csv'
class Aluno
  attr_reader :nome
  attr_reader :matricula
  attr_reader :telefone
  attr_reader :email
  attr_reader :uffmail
  attr_reader :status

  def initialize(linha)
    @nome = linha["nome"]
    @matricula = linha["matricula"]
    @telefone= linha["telefone"]
    @email= linha["email"]
    @uffmail= linha["uffmail"]
    @status= linha["status"]
  end

end