shared_context 'api data', shared_context: :metadata do
  let!(:auth_token) { create(:token) }
  let(:key) { auth_token.key }

  def authenticate_token
    request.headers['AUTHORIZATION'] = "Token #{key}"
  end
end
