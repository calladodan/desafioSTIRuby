
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
end