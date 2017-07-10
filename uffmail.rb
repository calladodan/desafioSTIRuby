require 'csv'
require_relative 'db'

class UFFMail

  def self.gera_email(aluno, arquivo)
    nomes = aluno.nome.split(" ")
    contador = 1
    lista = []

    #Opção 1 Primeira letra (ou mais) do primeiro nome + ultimo nome
    novo = nomes[0].byteslice(0,contador) << nomes[2] << "@id.uff.br"

    #Caso já exista algum assim vai aumentando
    #exemplo: Nome: Paulo Silva
    #primeira tentativa = psilva@id.uff.br
    #segunda tentativa = pasilva@id.uff.br
    while arquivo.existe_uffmail?(novo)
        contador+=1
        novo = nomes[0].byteslice(0,contador) << nomes[2] << "@id.uff.br"
    end
    lista << novo.downcase
    contador = 1

    #Opção 2: primeiroNome-últimoNome
    #exemplo: Nome: Paulo Silva
    #primeira tentativa = paulo-silva@id.uff.br
    #segunda tentativa = paulo-silva1@id.uff.br
    #Terceira tentativa = paulo-silva2@id.uff.br
    novo = nomes[0]<< "-" << nomes[2]
    if arquivo.existe_uffmail?(novo)
      novo << contador.to_s

      while arquivo.existe_uffmail?(novo)
        novo.succ
      end
    end

  novo<<"@id.uff.br"
  contador =1
  lista<<novo.downcase

  #Opção3: Primeira letra do primeiro nome + '.' + ultimo nome
    #exemplo: Nome: Paulo Silva
    #primeira tentativa = p.silva@id.uff.br
    #segunda tentativa = p.silva1@id.uff.br
    #Terceira tentativa = p.silva2@id.uff.br
  novo = nomes[0].byteslice(0,contador)<<"."<<nomes[2]

    if arquivo.existe_uffmail?(novo)
      novo << contador.to_s

      while arquivo.existe_uffmail?(novo)
        novo.succ
      end
    end
  novo << "@id.uff.br"

  lista << novo.downcase


  return lista
  end
end