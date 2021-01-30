require 'rails_helper'

describe 'タスク管理機能' do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let(:user_admin) { FactoryBot.create(:user, name: '管理者ユーザー', email: 'admin@example.com', admin: true) }
  let(:user_guest) { FactoryBot.create(:user, name: 'ゲストユーザー', email: 'guest@example.com', admin: false) }

  let!(:task_a1) { FactoryBot.create(:task, name: 'タスクA-1', user: user_a)}
  let!(:task_a2) { FactoryBot.create(:task, name: 'タスクA-2', user: user_a)}
  let!(:task_a3) { FactoryBot.create(:task, name: 'タスクA-3', user: user_a)}
  let!(:task_b1) { FactoryBot.create(:task, name: 'タスクB-1', user: user_b)}

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  describe 'ナビゲーション機能' do
    context '管理者権限のあるユーザーがログインしている時' do
      let(:login_user) { user_admin }

      it 'ユーザー一覧が表示されること' do
        expect(page).to have_content 'ユーザー一覧'
      end
    end

    context '管理者権限がないユーザーがログインしている時' do
      let(:login_user) { user_guest }

      it 'ユーザー一覧が表示されないこと' do
        expect(page).to have_no_content 'ユーザー一覧'
      end
    end
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content 'タスクA-1'
        expect(page).to have_content 'タスクA-2'
        expect(page).to have_content 'タスクA-3'
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content 'タスクA-1'
        expect(page).to have_no_content 'タスクA-2'
        expect(page).to have_no_content 'タスクA-3'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ユーザーAのタスクが表示される' do
        visit task_path(task_a1)
        expect(page).to have_content 'タスクA-1'
      end
    end

    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }

      it 'ユーザーBのタスクが表示される' do
        visit task_path(task_b1)
        expect(page).to have_content 'タスクB-1'
      end
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '登録する'
    end

    context '新規作成画面で名称を入力したとき' do
      let(:task_name) { 'いっぱい眠る' }

      it '登録に成功する' do
        expect(page).to have_selector '.alert-success', text: 'タスク「いっぱい眠る」を登録しました。'
      end
    end

    context '新規作成画面で名称を入力していないとき' do
      let(:task_name) { '' }

      it '登録に失敗する' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end
end
