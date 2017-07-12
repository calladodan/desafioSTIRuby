require 'csv'
require_relative 'aluno'

class DB
  def initialize (arquivo)
    @arquivo = arquivo
  end

  def busca_mat(matricula)
    CSV.foreach(@arquivo, headers:true) do |linha|

      return Aluno.new(linha) if linha["matricula"]==matricula
      end
  end

  def existe_uffmail?(uffm)
    CSV.foreach(@arquivo,headers:true) do |linha|
      if linha["uffmail"]==uffm
        return true
      end
    end
    false
  end

  def atualiza_uffmail(aluno, uffmail)
    CSV.open("temp.csv", "wb") do |csv|

      CSV.foreach(@arquivo,headers:true, return_headers:true)do |linha|

        if linha["matricula"]== aluno.matricula
          linha["uffmail"] = uffmail
          csv << linha
          puts linha.inspect
        else
          csv << linha
          puts linha.inspect
        end

      end
    end

    File.rename("temp.csv", @arquivo )

  end
end