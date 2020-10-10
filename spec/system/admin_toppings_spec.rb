require 'rails_helper'

RSpec.describe "AdminToppings", type: :system do
  let(:admin) { create(:admin) }
  let!(:shop) { create(:shop, admin_id: admin.id) }

  context 'トッピングの新規登録' do
    let(:topping) { build(:topping, admin_id: admin.id)}

    it '正しい情報を入力すれ新規登録ができる' do
      sign_in_admin(admin)
      click_on '新規登録'

      fill_in "topping[name]", with: topping.name
      fill_in "topping[price]", with: topping.price
      expect{ click_button 'topping-submit' }.to change { Topping.count }.by(1)
      expect(current_path).to eq new_admins_product_path
    end
  end
  context '販売の開始・停止' do
    let!(:product) { create(:product, admin_id: admin.id, display: true) }

    context '販売停止の状態' do
      let!(:topping) { create(:topping, display: false) }

      it '「販売する」をクリックするとトップページに表示され、購入可能となる' do
        sign_in_admin(admin)
        click_on '登録一覧'
        page.all(".topping-display")[0].click
        visit product_path(product)
        expect(page).to have_content(topping.name)
      end
    end

    context '販売中の状態' do
      let!(:topping) { create(:topping, display: true, admin_id: admin.id) }

      it '「販売停止する」をクリックするとトップページから表示がなくなり、購入不可となる' do
        sign_in_admin(admin)
        click_on '登録一覧'
        page.all(".topping-display")[0].click
        visit product_path(product)
        expect(page).to have_no_content(topping.name)
      end
    end
  end

  context 'トッピングの編集' do
    let!(:topping) { create(:topping, display: true, admin_id: admin.id) }

    context 'トッピングの情報' do
      it '編集対象のトッピング情報が存在する' do
        sign_in_admin(admin)
        click_on '登録一覧'
        page.all(".topping-edit")[0].click
        expect(find('#topping_name').value).to eq topping.name
        expect(find('#topping_price').value).to eq topping.price.to_s
      end
    end

    context 'トッピングが選択されて買い物かご追加されていない、かつ購入されていない' do
      it '編集できる' do
        sign_in_admin(admin)
        click_on '登録一覧'
        page.all(".topping-edit")[0].click
        fill_in "topping[name]", with: "こんなところまでご覧いただきありがとうございます"
        expect{ click_button 'topping-submit' }.to change { Topping.count }.by(0)
        expect(current_path).to eq admins_products_path
        expect(page).to have_content("こんなところまでご覧いただきありがとうございます")
      end
    end

    context 'トッピングが選択されて買い物かごに追加されている、または購入されたことがある' do
      let!(:product_topping_relation) { create(:product_topping_relation, topping_id: topping.id) }
      it '編集できない' do
        sign_in_admin(admin)
        click_on '登録一覧'
        page.all(".topping-edit")[0].click
        expect(current_path).to eq admins_products_path
        expect(page).to have_content("「#{topping.name}」は編集・削除ができません")
      end
    end
  end

  context 'トッピングの削除' do
    let!(:topping) { create(:topping, display: true, admin_id: admin.id) }

    context 'トッピングが選択されて買い物かご追加されていない、かつ購入されていない' do
      it '削除できる' do
        sign_in_admin(admin)
        click_on '登録一覧'

        expect{ page.all(".topping-delete")[0].click }.to change { Topping.count }.by(-1)
        expect(current_path).to eq admins_products_path
        expect(page).to have_content("「#{topping.name}」を削除しました")
      end
    end

    context 'トッピングが買い物かごに追加されている、または購入されたことがある' do
      let!(:product_topping_relation) { create(:product_topping_relation, topping_id: topping.id) }

      it '削除できない' do
        sign_in_admin(admin)
        click_on '登録一覧'
        expect{ page.all(".topping-delete")[0].click }.to change { Topping.count }.by(0)
        expect(current_path).to eq admins_products_path
        expect(page).to have_content("「#{topping.name}」は削除できませんでした")
      end
    end
  end
end
