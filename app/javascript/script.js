
$(function() {
    $('.menu-trigger').click(function(event) {
        $(this).toggleClass('active');
        $('#hamburger').fadeToggle();
        event.preventDefault();
  });
});

function sliderStart() {

    const slide = document.getElementById('slide_wrap');      //スライダー親
    const slideItem = slide.querySelectorAll('.slide_item');   //スライド要素
    const totalNum = slideItem.length - 1;                     // スライドの枚数を取得
    const FadeTime = 2000;                                     //フェードインの時間
    const IntarvalTime = 5000;                                 //クロスフェードさせるまでの間隔
    let actNum = 0;                                            //現在アクティブな番号
    let nowSlide;                                              //現在表示中のスライド
    let NextSlide;

}