require 'rails_helper'

RSpec.describe "AdminProducts", type: :system do
  let(:admin) { create(:admin) }
  let!(:shop) { create(:shop, admin_id: admin.id) }

  context '商品の新規登録' do
    let(:product) { build(:product, admin_id: admin.id)}

    it '正しい情報を入力すれ新規登録ができる' do
      sign_in_admin(admin)
      click_on '新規登録'
      attach_file 'product[image]', "#{Rails.root}/spec/fixtures/sample_ramen.jpg"
      fill_in "product[name]", with: product.name
      fill_in "product[text]", with: product.text
      find("option[value='#{product.category_id}']").select_option
      fill_in "product[price]", with: product.price
      expect{ click_button 'product-submit' }.to change { Product.count }.by(1)
      expect(current_path).to eq new_admins_product_path
    end
  end

  context '販売の開始・停止' do
    let!(:other_product) { create(:product, admin_id: admin.id) }

    context '商品が販売停止の状態' do
      let!(:product) { create(:product, display: false) }

      it '「販売する」をクリックするとトップページに表示され、購入可能となる' do
        sign_in_admin(admin)
        click_on '登録一覧'
        page.all(".display")[0].click
        visit products_path
        expect(page).to have_content(product.name)
      end
    end

    context '商品が販売中の状態' do
      let!(:product) { create(:product, display: true, admin_id: admin.id) }

      it '「販売停止する」をクリックするとトップページから表示がなくなり、購入不可となる' do
        sign_in_admin(admin)
        click_on '登録一覧'
        page.all(".display")[0].click
        visit root_path
        expect(page).to have_no_content(product.name)
      end
    end
  end

  context '商品の編集' do
    let!(:product) { create(:product, display: true, admin_id: admin.id) }

    context '商品の情報' do
      it '編集対象の商品情報が存在する' do
        sign_in_admin(admin)
        click_on '登録一覧'
        click_on '編集する'
        expect(find('#product_name').value).to eq product.name
        expect(find('#product_text').value).to eq product.text
        expect(page).to have_select('product[category_id]', selected: "ラーメン")
        expect(find('#product_price').value).to eq product.price.to_s
      end
    end

    context '商品が買い物かご追加されていない、かつ購入されていない' do
      it '編集できる' do
        sign_in_admin(admin)
        click_on '登録一覧'
        click_on '編集する'
        fill_in "product[name]", with: "ポンコツ醤油ラーメン"
        expect{ click_button 'product-submit' }.to change { Product.count }.by(0)
        expect(current_path).to eq admins_products_path
        expect(page).to have_content("ポンコツ醤油ラーメン")
      end
    end

    context '商品が買い物かごに追加されている、または購入されたことがある' do
      let!(:product_topping) { create(:product_topping, product_id: product.id) }
      it '編集できない' do
        sign_in_admin(admin)
        click_on '登録一覧'
        click_on '編集する'
        expect(current_path).to eq admins_products_path
        expect(page).to have_content("「#{product.name}」は編集・削除ができません")
      end
    end
  end

  context '商品の削除' do
    let!(:product) { create(:product, display: true, admin_id: admin.id) }

    context '商品が買い物かご追加されていない、かつ購入されていない' do
      it '削除できる' do
        sign_in_admin(admin)
        click_on '登録一覧'
        expect{ click_on '削除する' }.to change { Product.count }.by(-1)
        expect(current_path).to eq admins_products_path
        expect(page).to have_content("「#{product.name}」を削除しました")
      end
    end

    context '商品が買い物かごに追加されている、または購入されたことがある' do
      let!(:product_topping) { create(:product_topping, product_id: product.id) }

      it '削除できない' do
        sign_in_admin(admin)
        click_on '登録一覧'
        expect{ click_on '削除する' }.to change { Product.count }.by(0)
        expect(current_path).to eq admins_products_path
        expect(page).to have_no_content("「#{product.name}」を削除しました")
        expect(page).to have_content(product.name)
        expect(page).to have_content(product.text)
      end
    end
  end
end
