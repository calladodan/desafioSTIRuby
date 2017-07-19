require 'aluno'

describe Aluno do
  let(:nome){"daniel callado parrilha de lima"}
  let(:matricula){"109647"}
  let(:telefone){"982191409"}
  let(:email){"danielcplima@gmail.com"}
  let(:uffmail){}
  let(:ativo){true}
  let(:aluno_valido) {Aluno.new(nome, matricula,telefone,email,uffmail, ativo)} 
  let(:aluno_invalido){Aluno.new(nome, matricula,telefone,email,"dcallado@id.uff.br",false)}

  describe "#possui_uffmail?" do
    context "quando possui UFFMail" do
      it "retorna True" do
        expect(aluno_invalido.possui_uffmail?).to be_truthy
      end  
    end
    context "quando não possui UFFMail" do
      it "retorna false" do
        expect(aluno_valido.possui_uffmail?).to be_nil
      end  
    end  
  end

  describe "#ativo?" do
    context "quando está ativo" do
      it "retorna True" do
        expect(aluno_valido.ativo?).to be true
      end
    end
    context "quando está inativo" do
      it "retorna false" do
        expect(aluno_invalido.ativo?).to be false
      end  
    end  
  end
  
  describe "#pode_atualizar_uffmail?" do
    context "quando não possui UFFmail e está ativo" do
      it "retorna true" do
        expect(aluno_valido.pode_atualizar_uffmail?).to be true
      end
    end
    context "quando possui UFFMail ou está inativo" do
      it "retorna false" do
        expect(aluno_invalido.pode_atualizar_uffmail?).to be false
      end
    end
  end
  
  describe "#primeiro_nome" do
    it "retorna primeiro nome capitalized" do
      expect(aluno_valido.primeiro_nome).to eql "Daniel"
    end    
  end  
end  
