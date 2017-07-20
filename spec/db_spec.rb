require 'db'

describe DB do
  let(:arquivo){DB.new('spec/teste_lista.csv')}
  let(:ativo_com_uffmail){"105794"}
  let(:ativo_sem_uffmail){"109647"}
  let(:inativo_com_uffmail){"101209"}
  let(:inativo_sem_uffmail){"100484"}
  let(:matricula_inexistente){"9999999"}
  let(:uffmail_inexistente){"dcall@id.uff.br"}
  let(:uffmail_existente){"uffmail@id.uff.br"}

  describe "#busca_matricula" do
    context "quando encontra uma matrícula" do
      it "retorna uma CSV Row do arquivo" do
        expect(arquivo.busca_matricula(ativo_com_uffmail)).to be_a(CSV::Row)
      end
    end
    context "quando não encontra uma matrícula" do
      it "retorna nil" do
        expect(arquivo.busca_matricula(matricula_inexistente)).to be_nil
      end
    end
  end

  describe "#existe_uffmail?" do
    context "quando encontra UFFMail igual no arquivo" do
      it "retorna false" do
        expect(arquivo.existe_uffmail?(uffmail_inexistente)).to be false
      end
    end
    context "quando não encontra UFFMail igual no arquivo" do
      it "retorna true" do
        expect(arquivo.existe_uffmail?(uffmail_existente)).to be true
      end
    end
  end

  describe "#atualiza_uffmail" do
    context "quando encontra a linha com a matricula igual" do
      it "inclui o 'uffmail' no campo correspondente da linha do arquivo" do
        arquivo.atualiza_uffmail(ativo_sem_uffmail,"novo_uffmail@id.uff.br")
        busca = arquivo.busca_matricula(ativo_sem_uffmail)
        expect(busca["uffmail"]).to eq("novo_uffmail@id.uff.br")
        arquivo.atualiza_uffmail(ativo_sem_uffmail,nil)
      end
    end
  end
end

