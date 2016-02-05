(function ($) {


/*
 * Limitar ao footer o indicador de passos da contratação de seguros
 */
// $(window).on('scroll', function(){
//     var scrollBottom = $(window).scrollTop() + $(window).height(),
//         footerTop = $('footer').position().top,
//         pageIndicator = $('.page-indicator');

//     positionVal = (scrollBottom >= footerTop) ? 'absolute' : 'fixed';
//     pageIndicator.css('position', positionVal);
// });

/*
 * Sistemas de tabs do site
 */
var tabs = $('.tabs li a'),
    contentTabs = $('.tab-content');

tabs.on('click', function (e){
    e.preventDefault();

    var tab = $(this),
        tabContent = $('[data-tab='+this.hash.substring(1)+']');

    tabs.parent().removeClass('active');
    contentTabs.removeClass('active');
    tab.parent().addClass('active');
    tabContent.addClass('active');

    // location.hash = tab.attr('href');
});

if (tabs.length && location.hash) {
    tabs.filter('[href='+location.hash+']').trigger('click');
}



/*
 * Scroll romantico do click do menu
 */
var sweetScroll = function(e) {
    var target = $(this),
        hash = target.get(0).hash,
        section = $(hash);

    if (section.length) {
        e.preventDefault();

        $('html, body').animate({
            'scrollTop': section.offset().top
        }, 500, function () {
            if (history.pushState)
                history.pushState(null, null, hash);
            else
                location.hash = hash;
        });
    }
};

var navAnchors = $('.unlogged-nav li:not(:last-child) a');
navAnchors.on('click', sweetScroll);
$('.home-page .call-to-action').on('click', sweetScroll);


/*
 * Visualização da foto na pagina de edição de perfil
 */
var inputPhoto = $('.user-edit-profile [name=photo]');

inputPhoto.parent().parent().parent().css('display','none');

$('.edit-photo-profile').on('click', function(){
    inputPhoto.trigger('click');
    console.log(inputPhoto);
});


/*
 * Edição de imagem na edição de perfil da corretora
 */
var brokeragePhoto = $('.brokerage-data #id_brokerage_logo');

brokeragePhoto.parent().css('display','none');

$('.brokerage-data .brokerage-profile img').on('click', function(){
    brokeragePhoto.trigger('click');
});


/*
 * Formulário de edição de perfil
 */

var editProfileForm = $('.profile-edit-form');

editProfileForm.find('[name=photo]').parent().hide();

editProfileForm.find('.change-photo').on('click', function (e) {
    e.preventDefault();
    $('[name=photo]').trigger('click');
});

})(jQuery);
