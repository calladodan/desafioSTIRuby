require 'csv'

class DB
  attr_reader :path
  def initialize (path)
    @path = path
  end

  #Busca matrícula no arquivo e retorna uma hash da linha com matrícula igual
  def busca_matricula(matricula)
    CSV.foreach(path, headers: true) do |linha|
      return linha if linha['matricula']==matricula
    end
  end

  #Verifica se já existe um UFFMail igual ao passado como parâmetro no arquivo
  def existe_uffmail?(uffmail)
    CSV.foreach(path,headers: true) do |linha|
      if linha["uffmail"]==uffmail
        return true
      end
    end
    false
  end

  #Atualiza o arquivo, incluindo o UFFMail passado
  def atualiza_uffmail(matricula, uffmail)
    CSV.open("temp.csv", "wb") do |csv|
      CSV.foreach(path,headers: true, return_headers: true) do |linha|
        linha["uffmail"] = uffmail if linha["matricula"]== matricula
        csv << linha
      end
    end

    File.rename("temp.csv", path )
    puts "UFFMail atualizado com sucesso."
  end
end