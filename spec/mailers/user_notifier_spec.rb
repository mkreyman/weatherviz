require "spec_helper"

describe UserNotifier do
  let(:user) { FactoryGirl.build_stubbed(:user, token: '1234567890') }

  describe "signed_up" do
    let(:mail) { UserNotifier.signed_up(user) }

    it "renders the headers" do
      mail.subject.should eq('Please verify your e-mail address')
      mail.to.should eq([user.email])
      mail.from.should eq(['accounts@weatherviz.org'])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hello #{user.first_name.titleize}")
      mail.body.encoded.should match(verify_email_url(user.token))
    end
  end

  describe "verified" do
    let(:mail) { UserNotifier.verified(user) }

    it "renders the headers" do
      mail.subject.should eq('Thank you for verifying your e-mail address')
      mail.to.should eq([user.email])
      mail.from.should eq(['accounts@weatherviz.org'])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hello #{user.first_name.titleize}")
    end
  end

  describe "verify" do
    let(:mail) { UserNotifier.verify(user) }

    it "renders the headers" do
      mail.subject.should eq('Please verify your e-mail address')
      mail.to.should eq([user.email])
      mail.from.should eq(['accounts@weatherviz.org'])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hello #{user.first_name.titleize}")
      mail.body.encoded.should match(verify_email_url(user.token))
    end
  end

end
