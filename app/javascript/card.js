if (document.URL.match(/cards/)) {
  const pay = () => {
    Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
    const form = document.getElementById("charge-form");
    form.addEventListener("submit", (e) => {
      e.preventDefault();

      // カード情報の取得先を設定
      const formResult = document.getElementById("charge-form");
      const formData = new FormData(formResult);

      const card = {
        number: formData.get("number"),
        cvc: formData.get("cvc"),
        exp_month: formData.get("exp_month"),
        exp_year: `20${formData.get("exp_year")}`
      };
      Payjp.createToken(card, (status, response) => {
        if (status === 200){
          const token = response.id;
          const renderDom = document.getElementById("charge-form");
          const tokenObj = `<input value=${token} type="hidden" name="card_token">`;
          renderDom.insertAdjacentHTML("beforeend", tokenObj);

          // パラメーターにカード情報を送らない記述
          document.getElementById("number").removeAttribute("name");
          document.getElementById("cvc").removeAttribute("name");
          document.getElementById("exp_month").removeAttribute("name");
          document.getElementById("exp_year").removeAttribute("name");
          
          // 送信後にフォーム情報をリセット
          document.getElementById("charge-form").submit();
          document.getElementById("charge-form").reset();
        }
      });
    });
  };
  window.addEventListener("load", pay);
}