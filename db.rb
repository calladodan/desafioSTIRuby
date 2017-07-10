require 'csv'
require_relative 'aluno'

class DB
  def initialize (arquivo)
    @arquivo = arquivo
  end

  def busca_mat(matricula)
    CSV.foreach(@arquivo, headers:true) do |linha|
      if linha["matricula"]==matricula
        if linha["status"]=="Ativo"
          if linha["uffmail"]==nil
            return linha
          else
            return "Usuário já possui UFFmail associado."
          end
        else
          return "Usuário não está ativo"
        end
      end
    end
    "Matrícula não encontrada"
  end

  def existe_uffmail?(uffm)
    CSV.foreach(@arquivo,headers:true) do |linha|
      if linha["uffmail"]==""
        return true
      end
    end
    false
  end

  def atualiza_uffmail(aluno, uffmail)
    CSV.open('temp.csv', 'wb') do |csv|
      CSV.each(@arquivo)do |linha|
        if linha.header_row?
          csv << linha
        end
        elsif
      end
    end
  end
end