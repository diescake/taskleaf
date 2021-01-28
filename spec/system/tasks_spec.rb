require 'rails_helper'

describe 'タスク管理機能' do
  describe '一覧表示機能' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }

    before do
      FactoryBot.create(:task, name: 'タスクA', user: user_a)
      FactoryBot.create(:task, name: 'タスクB', user: user_a)
      FactoryBot.create(:task, name: 'タスクC', user: user_a)

      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログインする'
    end

    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content 'タスクA'
        expect(page).to have_content 'タスクB'
        expect(page).to have_content 'タスクC'
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content 'タスクA'
        expect(page).to have_no_content 'タスクB'
        expect(page).to have_no_content 'タスクC'
      end
    end
  end
end
