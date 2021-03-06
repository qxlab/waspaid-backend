require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'GET /transactions/:id', type: :request do
  let(:user) {Fabricate(:user)}
  let(:auth_headers) do
    Devise::JWT::TestHelpers.auth_headers(
        {'Accept': 'application/json', 'Content-Type': 'application/json'},
        user
    )
  end
  let(:invoice) {Fabricate(:invoice, user: user)}
  let(:transaction) {Fabricate(:transaction, invoice: invoice)}
  let(:url) {'/transactions'}

  context 'test invoice that belongs to user' do
    before do
      get "#{url}/#{transaction.id}", headers: auth_headers
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'match the schema' do
      expect(response).to match_response_schema('transaction')
    end
  end
end
