require_relative 'db'

class GeradorUffmail

  #Gera um array com as sugestões de UFFMail
  def self.gera_lista_email(aluno, arquivo)
    nomes = aluno.nome.split(" ")
    lista = []
    lista << inicial_mais_ultimo_nome(nomes, arquivo)
    lista << primeironome_hifen_ultimonome(nomes, arquivo)
    lista << inicial_ponto_ultimonome(nomes, arquivo)
    return lista
  end

  private
  #Retorna uma string de sugestão de UFFMail de acordo com as regras abaixo
  #Opção 1 Primeira letra (ou mais) do primeiro nome + ultimo nome
  #Caso já exista algum assim vai aumentando a substring inicial
  #exemplo: Nome: Paulo Silva
  #primeira tentativa = psilva@id.uff.br
  #segunda tentativa = pasilva@id.uff.br
  def self.inicial_mais_ultimo_nome(nomes, arquivo)
    contador = 1
    sugestao = nomes[0].byteslice(0,contador) << nomes[2] << "@id.uff.br"
    sugestao
    while arquivo.existe_uffmail?(sugestao)
      contador+=1
      sugestao = nomes[0].byteslice(0,contador) << nomes[2] << "@id.uff.br"
      sugestao
    end
    sugestao
  end

  #Retorna uma string de sugestão de UFFMail de acordo com as regras abaixo
  #Opção 2: primeiroNome-últimoNome
  #exemplo: Nome: Paulo Silva
  #primeira tentativa = paulo-silva@id.uff.br
  #segunda tentativa = paulo-silva1@id.uff.br
  #Terceira tentativa = paulo-silva2@id.uff.br
  def self.primeironome_hifen_ultimonome(nomes, arquivo)

    contador=1
    sugestao = nomes[0]<< "-" << nomes[2]
    sugestao_com_arroba = "#{sugestao}"
    sugestao_com_arroba << "@id.uff.br"

    if arquivo.existe_uffmail?(sugestao_com_arroba)
      sugestao << contador.to_s
      sugestao_com_arroba = "#{sugestao}"
      sugestao_com_arroba<< "@id.uff.br"

      while arquivo.existe_uffmail?(sugestao_com_arroba)
        sugestao.succ!
        sugestao_com_arroba = "#{sugestao}"
        sugestao_com_arroba << "@id.uff.br"
      end
    end
    sugestao_com_arroba
  end

  #Opção3: Primeira letra do primeiro nome + '.' + ultimo nome
  #exemplo: Nome: Paulo Silva
  #primeira tentativa = p.silva@id.uff.br
  #segunda tentativa = p.silva1@id.uff.br
  #Terceira tentativa = p.silva2@id.uff.br
  def self.inicial_ponto_ultimonome(nomes, arquivo)

    contador =1
    sugestao = "#{nomes[0].byteslice(0,contador)}.#{nomes[2]}"

    sugestao_com_arroba = "#{sugestao}"

    sugestao_com_arroba << "@id.uff.br"

    if arquivo.existe_uffmail?(sugestao_com_arroba)
      sugestao << contador.to_s
      sugestao_com_arroba = "#{sugestao}"
      sugestao_com_arroba << "@id.uff.br"

      while arquivo.existe_uffmail?(sugestao_com_arroba)
        sugestao.succ!
        sugestao_com_arroba = "#{sugestao}"
        sugestao_com_arroba << "@id.uff.br"
        puts sugestao_com_arroba
      end
    end
    sugestao_com_arroba
  end


end