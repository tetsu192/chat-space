require 'rails_helper'

describe Message do
  describe '#create' do
    let(:message) { build(:message) }

    context 'when a text exist' do
      it 'is valid with a text' do
        message[:image] = ''
        expect(message).to be_valid
      end
    end

    context 'when an image exist' do
      it 'is valid with an image' do
        message[:text] = ''
        expect(message).to be_valid
      end
    end

    context 'when a text and an image exist' do
      it 'is valid with a text and an image' do
        expect(message).to be_valid
      end
    end

    context 'when a text and an image are blank' do
      it 'is invalid without a text and an image' do
        message.valid?
        expect(message.errors[:text || :image]).to include('を入力してください。')
      end
    end

    context 'when a group_id is blank' do
      it 'is invalid without a group_id' do
        message = build(:message, group_id: '')
        message.valid?
        expect(message.errors[:group_id]).to include('を入力してください。')
      end
    end

    context 'when a user_id is blank' do
      it 'is invalid without a user_id' do
        message = build(:message, user_id: '')
        message.valid?
        expect(message.errors[:user_id]).to include('を入力してください。')
      end
    end

  end
end
