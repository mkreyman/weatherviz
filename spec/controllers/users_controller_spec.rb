require 'spec_helper'

describe UsersController do

  it 'should prevent signing up as admin user' do
    @user = create(:user)
    put :update, { id: @user, user: attributes_for(:user, admin: true) }
    @user.reload

    expect(@user.reload).not_to be_admin
  end
end