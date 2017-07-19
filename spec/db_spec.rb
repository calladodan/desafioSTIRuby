require 'db'

describe DB do
  let(:path){"lib/lista.csv"}
  let(:arquivo){DB.new(path)}
  let(:matricula){"109647"}
  describe "#busca_matricula" do
    context "quando encontra uma matrícula" do
      it "retorna uma linha do arquivo" do
        expect(arquivo.busca_matricula(matricula)).to be_a(CSV::Row)
      end
    end
  end  
end  
