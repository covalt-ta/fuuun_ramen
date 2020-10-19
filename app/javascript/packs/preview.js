document.addEventListener('DOMContentLoaded', function () {
  const ImageList = document.getElementById('product-image-list');
  document.getElementById('product_image').addEventListener('change', function (e) {
    // 画像が表示されている場合のみ、すでに存在している画像を削除する
    const imageContent = document.querySelector('img');
    if (imageContent) {
      imageContent.remove();
    }
    const file = e.target.files[0]
    const blob = window.URL.createObjectURL(file);

    const imageElement = document.createElement('div');
    const blobImage = document.createElement('img');
    blobImage.setAttribute('src', blob);

    imageElement.appendChild(blobImage);
    ImageList.appendChild(imageElement);
  });
});

