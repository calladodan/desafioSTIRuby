
class Aluno
  attr_reader :nome, :matricula, :telefone, :email, :uffmail, :status

  def initialize(csv_row)
    @nome = csv_row["nome"].downcase
    @matricula = csv_row["matricula"]
    @telefone= csv_row["telefone"]
    @email= csv_row["email"]
    @uffmail= csv_row["uffmail"]
    @status= adiciona_status(csv_row["status"])
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

  def primeiro_nome
    @nome.split(" ")[0].capitalize
  end

  private
    def adiciona_status(status)
      return status == "Ativo"
    end

end