require 'csv'
require_relative 'db'

class GeradorUffmail

  def self.gera_lista_email(aluno, arquivo)
    nomes = aluno.nome.split(" ")
    lista = []
    lista << inicial_mais_ultimo_nome(nomes, arquivo)
    lista << primeironome_hifen_ultimonome(nomes, arquivo)
    lista << inicial_ponto_ultimonome(nomes, arquivo)
    return lista
  end

  private

    def self.inicial_mais_ultimo_nome(nomes, arquivo)
      contador = 1
      #Opção 1 Primeira letra (ou mais) do primeiro nome + ultimo nome
      sugestao = nomes[0].byteslice(0,contador) << nomes[2] << "@id.uff.br"

      #Caso já exista algum assim vai aumentando
      #exemplo: Nome: Paulo Silva
      #primeira tentativa = psilva@id.uff.br
      #segunda tentativa = pasilva@id.uff.br
      while arquivo.existe_uffmail?(sugestao)
        contador+=1
        sugestao = nomes[0].byteslice(0,contador) << nomes[2] << "@id.uff.br"
      end
      sugestao.downcase
    end

    def self.primeironome_hifen_ultimonome(nomes, arquivo)
      #Opção 2: primeiroNome-últimoNome
      #exemplo: Nome: Paulo Silva
      #primeira tentativa = paulo-silva@id.uff.br
      #segunda tentativa = paulo-silva1@id.uff.br
      #Terceira tentativa = paulo-silva2@id.uff.br
      contador=1
      sugestao = nomes[0]<< "-" << nomes[2]
      if arquivo.existe_uffmail?(sugestao)
        sugestao << contador.to_s

        while arquivo.existe_uffmail?(sugestao)
          sugestao.succ

        end
      end
      sugestao<<"@id.uff.br"
      sugestao.downcase

    end

    def self.inicial_ponto_ultimonome(nomes, arquivo)
      #Opção3: Primeira letra do primeiro nome + '.' + ultimo nome
      #exemplo: Nome: Paulo Silva
      #primeira tentativa = p.silva@id.uff.br
      #segunda tentativa = p.silva1@id.uff.br
      #Terceira tentativa = p.silva2@id.uff.br
      contador =1
      sugestao = nomes[0].byteslice(0,contador)<<"."<<nomes[2]

      if arquivo.existe_uffmail?(sugestao)
        sugestao << contador.to_s

        while arquivo.existe_uffmail?(sugestao)
          sugestao.succ
        end
      end
      sugestao << "@id.uff.br"
      sugestao.downcase
    end


end