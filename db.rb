require 'csv'

class DB
  attr_reader :path
  def initialize (path)
    @path = path
  end

  #Busca matrícula no arquivo e retorna a linha com matrícula igual
  def busca_mat(matricula)
    CSV.foreach(@path, headers:true) do |linha|

      return linha if linha["matricula"]==matricula
      end
  end

  #Verifica se já existe um UFFMail igual ao passado no arquivo
  def existe_uffmail?(uffm)
    CSV.foreach(@path,headers:true) do |linha|
      if linha["uffmail"]==uffm
        return true
      end
    end
    false
  end

  #Atualiza o arquivo, incluindo o UFFMail passado
  def atualiza_uffmail(matricula, uffmail)
    CSV.open("temp.csv", "wb") do |csv|

      CSV.foreach(@path,headers:true, return_headers:true)do |linha|

        if linha["matricula"]== matricula
          linha["uffmail"] = uffmail
          csv << linha
        else
          csv << linha
        end

      end
    end

    File.rename("temp.csv", @path )

  end
end