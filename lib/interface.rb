require_relative 'gerador_uffmail'
require_relative 'db'
require_relative 'aluno'

class Interface

  #Inicia o contato com o usuário solicitando matricula
  # e repassa para selecao de emails caso encontre matrícula
  # e aluno esteja apto a atualizar o UFFMail (Ativo e não possui UFFMail)
  # caso contrário retorna para sí própria
  attr_reader :arquivo
  def initialize(arquivo)
    @arquivo = arquivo
  end

  def start
    aluno = solicita_matricula
    return msg_mat_nao_encontrada unless aluno

    if aluno.pode_atualizar_uffmail?
      tela_selecao_de_emails(aluno, gerar_lista(aluno))
    else
      !aluno.ativo? ? msg_nao_ativo : msg_possui_uffmail
    end
  end

  def solicita_matricula
    puts "Digite a matrícula desejada: "
    busca = arquivo.busca_matricula(gets.chomp)
    puts busca.is_a? CSV::Row
    gerar_aluno(busca) if busca
  end

  def gerar_aluno(busca)
    Aluno.new(
        busca["nome"].downcase,
        busca["matricula"],
        busca["telefone"],
        busca["email"],
        busca["uffmail"],
        busca["status"] == 'Ativo'
    )
  end

  def tela_selecao_de_emails(aluno, lista)
      selecao = seleciona_email(lista)
      selecao ? arquivo.atualiza_uffmail(aluno.matricula, selecao) : tela_selecao_de_emails(aluno, lista)
  end

  private

  def gerar_lista(aluno)
    puts "Olá,#{aluno.primeiro_nome}"
    puts "Abaixo estão as opções de escolha do seu UFFMail"
    GeradorUffmail.new(arquivo, aluno.nome.split(' ')).gera_lista
  end

  def imprime_lista_emails(lista)
    lista.each_with_index do |opcao, index|
      puts "#{index + 1} - #{opcao}"
    end
    puts "\nDigite o número da opção desejada e pressione Enter"
  end

  def seleciona_email(lista)
    imprime_lista_emails(lista)
    indice = gets.chomp.to_i

    unless (1..lista.length).cover? indice
      puts "Valor inválido."
      return nil
    end
    lista[indice-1]
  end

  def msg_mat_nao_encontrada
    puts 'Matrícula não encontrada!'
  end

  def msg_nao_ativo
    puts "Usuário não está ativo"
  end

  def msg_possui_uffmail
    puts "Usuário já possui UFFMail associado."
  end
end
