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
    @status= adiciona_status(linha["status"])
  end

  def possui_uffmail?
    return @uffmail != nil
  end

  def ativo?
    @status
  end

  def pode_atualizar_uffmail?
    return !possui_uffmail? && ativo?
  end

  private
    def adiciona_status(status)
      return status == "Ativo"
    end

end