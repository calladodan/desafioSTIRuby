require 'gerador_uffmail'

describe GeradorUffmail do
  let(:nomes){['daniel','callado','parrilha','de','lima']}
  let(:arquivo){DB.new('spec/teste_lista.csv')}
  let(:gerador){GeradorUffmail.new(arquivo,nomes)}

  describe '#gera_lista' do
    context 'quando gera lista correta de sugestoes' do
      it 'retorna array de sugestoes de UFFMail' do
        resultado = gerador.gera_lista
        expect(resultado[0]).to eql 'dlima@id.uff.br'
        expect(resultado[1]).to eql 'daniel-lima@id.uff.br'
        expect(resultado[2]).to eql 'd.lima@id.uff.br'
      end
    end
  end
end