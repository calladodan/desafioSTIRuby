class Aluno

  attr_reader :nome, :matricula, :telefone, :email, :uffmail

  def initialize(nome, matricula, telefone, email, uffmail, ativo)
    @nome = nome
    @matricula = matricula
    @telefone= telefone
    @email= email
    @uffmail= uffmail
    @ativo = ativo
  end

  def possui_uffmail?
    @uffmail
  end

  def ativo?
    @ativo
  end

  def pode_atualizar_uffmail?
    !possui_uffmail? && ativo?
  end

  def primeiro_nome
    @nome.split(' ').first.capitalize
  end

end