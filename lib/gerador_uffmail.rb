require_relative 'db'

class GeradorUffmail

  SUFFIX = '@id.uff.br'

  def initialize(arquivo, nomes)
    @arquivo = arquivo
    @nomes = nomes
  end

  def gera_lista
    [
      inicial_mais_ultimo_nome,
      primeironome_hifen_ultimonome,
      inicial_ponto_ultimonome
    ]
  end

  private
  attr_reader :arquivo, :nomes

  #Retorna uma string de sugestão de UFFMail de acordo com as regras abaixo
  #Opção 1 Primeira letra (ou mais) do primeiro nome + ultimo nome
  #Caso já exista algum assim vai aumentando a substring inicial
  #exemplo: Nome: Paulo Silva
  #primeira tentativa = psilva@id.uff.br
  #segunda tentativa = pasilva@id.uff.br
  def inicial_mais_ultimo_nome
    contador = 1
    sugestao = nomes.first[0, contador] + nomes.last
    while arquivo.existe_uffmail?(sugestao + SUFFIX)
      contador += 1
      sugestao = nomes.first[0, contador] + nomes.last
    end
    sugestao + SUFFIX
  end

  #Retorna uma string de sugestão de UFFMail de acordo com as regras abaixo
  #Opção 2: primeiroNome-últimoNome
  #exemplo: Nome: Paulo Silva
  #primeira tentativa = paulo-silva@id.uff.br
  #segunda tentativa = paulo-silva1@id.uff.br
  #Terceira tentativa = paulo-silva2@id.uff.br
  def primeironome_hifen_ultimonome
    contador=1
    sugestao = nomes.first << "-" << nomes.last

    if arquivo.existe_uffmail?(sugestao + SUFFIX)
      sugestao << contador.to_s

      while arquivo.existe_uffmail?(sugestao + SUFFIX)
        sugestao.succ!
      end
    end
    sugestao + SUFFIX
  end

  #Opção3: Primeira letra do primeiro nome + '.' + ultimo nome
  #exemplo: Nome: Paulo Silva
  #primeira tentativa = p.silva@id.uff.br
  #segunda tentativa = p.silva1@id.uff.br
  #Terceira tentativa = p.silva2@id.uff.br
  def inicial_ponto_ultimonome

    sugestao = "#{nomes.first[0, 1]}.#{nomes.last}"


    if arquivo.existe_uffmail?(sugestao + SUFFIX)
      sugestao << 1.to_s

      while arquivo.existe_uffmail?(sugestao + SUFFIX)
        sugestao.succ!
      end
    end
    sugestao + SUFFIX
  end
end