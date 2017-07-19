require 'aluno'

#falta testar os readers


describe Aluno do
  let(:nome){"daniel callado parrilha de lima"}
  let(:matricula){"109647"}
  let(:telefone){"982191409"}
  let(:email){"danielcplima@gmail.com"}
  let(:uffmail){}
  let(:ativo){true}
  let(:aluno) {Aluno.new(nome, matricula,telefone,email, uffmail, ativo)} 
  

  describe "#possui_uffmail?" do
    context "quando possui UFFMail" do
      it "retorna True" do
        expect(aluno.possui_uffmail?).to be_nil
      end  
    end  
  end

  describe "#ativo?" do
    context "quando está ativo" do
      it "retorna True" do
        expect(aluno.ativo?).to be true
      end
    end
  end
  
  describe "#pode_atualizar_uffmail?" do
    context "quando não possui UFFmail e está ativo" do
      it "retorna true" do
        expect(aluno.pode_atualizar_uffmail?).to be true
      end
    end
  end
  
  describe "#primeiro_nome" do
    it "retorna primeiro nome capitalized" do
      expect(aluno.primeiro_nome).to eql "Daniel"
    end    
  end  
end  
