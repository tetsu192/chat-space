require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }

  describe 'GET #index' do
    context 'when user logs in' do
    before do
      login_user user
    end

    before do
      get :index, params: { group_id: group.id }
    end

      it 'assigns the requested group to @group' do
        expect(assigns(:group)).to eq group
      end

      it 'populates an array of groups' do
        groups = user.groups
        expect(assigns(:groups)).to match(groups)
      end

      it 'assigns the requested message to @message' do
        message = Message.new
        expect(assigns(:message)).to be_a_new Message
      end

      it 'populates an array of messages' do
        messages = group.messages
        expect(assigns(:messages)).to match(messages)
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

    context 'when user does not log in' do
      before do
        get :index, params: { group_id: group.id }
      end

      it 'redirect to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do

    before do
        login_user user
    end

    before do
        get :index, params: { group_id: group.id }
    end

    context 'when user logs in and saves s message' do

      let(:message) { post :create, params: { message: attributes_for(:message), group_id: group.id } }

      it 'saves a new message' do
        expect{ message }.to change(Message, :count).by(1)
      end

      it 'redirect to group_messages_path' do
        message
        expect(response).to redirect_to(group_messages_path)
      end
    end

    context 'when user logs in and dose not save a message' do
      let(:message) { post :create, params: { message: attributes_for(:message, { text: nil, image: nil }), group_id: group.id } }
      it 'does not save a message' do
        expect{ message }.not_to change(Message, :count)
      end

      it 'includes the flash message' do
        message
        expect(flash[:alert]).to include('メッセージを入力してください')
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end
  end
end
