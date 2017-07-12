
class Interface
  def self.lista_emails(lista)
    contador = 1

    lista.each do |opcao|
      puts "#{contador} - #{opcao}"
      contador+=1
    end
  end

  def self.seleciona_email(lista)
    indice = gets.chomp.to_i

    if indice>lista.length || indice <1
      return nil
    end
    return lista[indice-1]
  end

  def self.start(arquivo)

    arquivo = DB.new(arquivo)

    puts "Digite a matrícula desejada: "
    mat = gets.chomp
    puts mat
    retorno = arquivo.busca_mat(mat)

    if retorno.is_a? Aluno
      principal(retorno, arquivo)
    else
      mat_nao_encontrada
      start(arquivo)
    end

  end

  def self.mat_nao_encontrada
    puts "Matrícula não encontrada!"
  end

  def self.principal(aluno, arquivo)

    if aluno.pode_atualizar_uffmail?

      lista = GeradorUffmail.gera_email(aluno, arquivo)

      puts "Digite o número da opção desejada:"
      Interface.lista_emails(lista)

      selecao = Interface.seleciona_email(lista)
      arquivo.atualiza_uffmail(aluno, selecao)
      puts "UFFMail atualizado com sucesso."
    else
      !aluno.ativo? ? mensagem_nao_ativo : mensagem_possui_uffmail
    end
    start(arquivo)
  end

  def self.mensagem_nao_ativo
    puts "Usuário não está ativo"
  end

  def self.mensagem_possui_uffmail
    puts "Usuário já possui UFFMail associado."
  end

end