require 'spec_helper'

describe '#needs_verification!' do
  let(:user) { FactoryGirl.create(:user, token: '', verified: true) }

  it "sets the verified email address field as false" do
    expect { user.needs_verification! }.to change(
        user, :verified_email?).from(true).to(false)
  end

  it "sets the token for the user" do
    expect { user.needs_verification! }.to change(user, :token)
  end

  it "sends a verification email" do
    expect { user.needs_verification! }.to change(
        ActionMailer::Base.deliveries, :count).by(1)
  end
end