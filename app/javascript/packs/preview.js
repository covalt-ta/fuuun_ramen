if (document.URL.match(/products\/new/)) {
  document.addEventListener('DOMContentLoaded', function () {
    const ImageList = document.getElementById('product-image-list');
    document.getElementById('product_image').addEventListener('change', function (e) {
      // 画像が表示されている場合のみ、すでに存在している画像を削除する
      const imageContent = document.querySelector('img');
      const divContent = document.querySelector('.product-image-wrapper')
      if (imageContent && divContent) {
        imageContent.remove();
        divContent.remove();
      }
      const file = e.target.files[0]
      const blob = window.URL.createObjectURL(file);

      const imageElement = document.createElement('div');
      const blobImage = document.createElement('img');
      imageElement.setAttribute('class', 'product-image-wrapper')
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('class', 'product-image');

      imageElement.appendChild(blobImage);
      ImageList.appendChild(imageElement);
    });
  });
}
