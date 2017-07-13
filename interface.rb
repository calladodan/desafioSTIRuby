require_relative 'gerador_uffmail'
require_relative 'db'
require_relative 'aluno'

class Interface

  #Inicia o contato com o usuário solicitando matricula
  # e repassa para selecao de emails caso encontre matrícula
  # e aluno esteja apto a atualizar o UFFMail (Ativo e não possui UFFMail)
  def self.start(arquivo)

    puts "Digite a matrícula desejada: "
    mat = gets.chomp
    busca = arquivo.busca_mat(mat)
    #Checa se a busca retornou alguma coisa
    if busca
      aluno = Aluno.new(busca)
      if aluno.pode_atualizar_uffmail?
        tela_selecao_de_emails(aluno, arquivo)
      else
        !aluno.ativo? ? msg_nao_ativo : msg_possui_uffmail
      end
    else
      msg_mat_nao_encontrada
    end
    start(arquivo)
  end

  #Tela principal
  def self.tela_selecao_de_emails(aluno, arquivo)
      puts "Olá,#{aluno.primeiro_nome}"
      puts "Abaixo estão as opções de escolha do seu UFFMail"
      lista = GeradorUffmail.gera_lista_email(aluno, arquivo)

      Interface.imprime_lista_emails(lista)

      selecao = Interface.seleciona_email(lista)
      selecao ? arquivo.atualiza_uffmail(aluno.matricula, selecao) : tela_selecao_de_emails(aluno, arquivo)
      start(arquivo)
  end

  private
  #Imprime na tela as sugestões de UFFMail de acordo com o array passado
  def self.imprime_lista_emails(lista)
    contador = 1

    lista.each do |opcao|
      puts "#{contador} - #{opcao}"
      contador+=1
    end
    puts "\nDigite o número da opção desejada e pressione Enter"
  end

  #Solicita ao usuário um valor da sugestão e retorna a
  #String correspondente de acordo com o valor passado
  def self.seleciona_email(lista)
    indice = gets.chomp.to_i

    if indice>lista.length || indice <1
      puts "Valor inválido."
      return nil
    end
    return lista[indice-1]
  end

  def self.msg_mat_nao_encontrada
    puts "Matrícula não encontrada!"
  end

  def self.msg_nao_ativo
    puts "Usuário não está ativo"
  end

  def self.msg_possui_uffmail
    puts "Usuário já possui UFFMail associado."
  end

end