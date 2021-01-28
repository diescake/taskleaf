require 'rails_helper'

describe 'タスク管理機能' do
  describe '一覧表示機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')

      FactoryBot.create(:task, name: 'タスクA', user: user_a)
      FactoryBot.create(:task, name: 'タスクB', user: user_a)
      FactoryBot.create(:task, name: 'タスクC', user: user_a)
    end

    context 'ユーザーAがログインしているとき' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content 'タスクA'
        expect(page).to have_content 'タスクB'
        expect(page).to have_content 'タスクC'
      end
    end

    context 'ユーザーBがログインしているとき' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: 'b@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content 'タスクA'
        expect(page).to have_no_content 'タスクB'
        expect(page).to have_no_content 'タスクC'
      end
    end
  end
end
