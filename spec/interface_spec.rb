require 'interface'

describe Interface do

  let(:interface){Interface.new(DB.new('spec/teste_lista.csv'))}
  let(:matricula_existente){'105794'}
  let(:matricula_inexistente){'99999999'}

  # describe '#start' do
  #   context 'quando não encontra matrícula' do
  #     it 'retorna mensagem de matricula não encontrada' do
  #
  #     end
  #   end
  # end

  # describe '#solicita_matricula' do
  #   context 'quando encontra matrícula' do
  #     it 'retorna um aluno' do
  #       expect(interface.solicita_matricula)
  #     end
  #   end
  # end
  describe '#gerar_aluno' do
    context 'quando é passado uma linha do arquivo' do
      it 'retorna um objeto aluno' do
        busca = interface.arquivo.busca_matricula(matricula_existente)
        expect(interface.gerar_aluno(busca)).to be_a Aluno
      end
    end
    context 'quando é passado um valor nulo' do
      it 'retorna nil' do
        busca = interface.arquivo.busca_matricula(matricula_inexistente)
        expect(busca).to be_nil
      end
    end
  end
end