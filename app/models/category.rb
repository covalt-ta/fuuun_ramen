class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'ラーメン' },
    { id: 3, name: '丼' },
    { id: 4, name: 'サイドメニュー' },
    { id: 5, name: 'ドリンク' },
    { id: 6, name: 'スイーツ' },
    { id: 7, name: 'アイテム' }
  ]
end
