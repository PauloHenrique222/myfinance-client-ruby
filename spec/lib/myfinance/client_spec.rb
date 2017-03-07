require "spec_helper"

describe Myfinance::Client do
  subject { client }

  describe "#initialize" do
    it "instantiates a new Myfinance::Http object" do
      expect(Myfinance::Http).to receive(:new).with("abc", nil)
      Myfinance::Client.new("abc")
    end

    context "when account_id is present" do
      it "instantiates a new Myfinance::Http object" do
        expect(Myfinance::Http).to receive(:new).with("abc", 123)
        Myfinance::Client.new("abc", 123)
      end
    end
  end

  describe "#authenticated?" do
    context "with a valid token" do
      it "returns true" do
        VCR.use_cassette("client/authenticated/true") { expect(subject.authenticated?).to be_truthy }
      end
    end

    context "with an invalid token" do
      subject { described_class.new("FAKE-TOKEN") }

      it "returns false" do
        VCR.use_cassette("client/authenticated/false") { expect(subject.authenticated?).to be_falsey }
      end
    end
  end

  describe "#entities" do
    it "instantiates a new Myfinance::Resources::Entity" do
      expect(Myfinance::Resources::Entity).to receive(:new).with(subject.http)
      subject.entities
    end
  end

  describe "#payable_accounts" do
    it "instantiates a new Myfinance::Resources::PayableAccount" do
      expect(Myfinance::Resources::PayableAccount).to receive(:new).with(subject.http)
      subject.payable_accounts
    end
  end

  describe "#receivable_accounts" do
    it "instantiates a new Myfinance::Resources::ReceivableAccount" do
      expect(Myfinance::Resources::ReceivableAccount).to receive(:new).with(subject.http)
      subject.receivable_accounts
    end
  end

  describe "#attachments" do
    it "instantiates a new Myfinance::Resources::Attachment" do
      expect(Myfinance::Resources::Attachment).to receive(:new).with(subject.http)
      subject.attachments
    end
  end

  describe "#categories" do
    it "instantiates a new Myfinance::Resources::Category" do
      expect(Myfinance::Resources::Category).to receive(:new).with(subject.http)
      subject.categories
    end
  end
end
