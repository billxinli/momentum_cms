var PageView;

PageView = (function() {

  //-- Initializer ----------------------------------------------------------
  function PageView(options) {
    this.$el = $(options.el);
    this.bindEvents();
  }

  //-- Utilities ------------------------------------------------------------
  PageView.prototype.$ = function(selector) {
    return this.$el.find(selector);
  };

  //-- Properties -----------------------------------------------------------
  PageView.prototype.blocksUrl = function() {
    return this.$el.data('blocks-url');
  };

  PageView.prototype.pageId = function() {
    return this.$el.data('page-id');
  };

  //-- Methods --------------------------------------------------------------
  PageView.prototype.bindEvents = function() {
    this.$el.on('change', '.template-select', $.proxy(this.fetchContentBlocks, this));
  };

  PageView.prototype.fetchContentBlocks = function(e) {
    var reqData = {template_id: $(e.currentTarget).val()};
    if(this.pageId() !== '') {
      reqData.page_id = this.pageId();
    }
    var request = $.get(this.blocksUrl(), reqData);
    request.then(function(res) {
      $('.content-fields').empty();
      $(res).find('.ajax-fields').appendTo('.content-fields');
    });
    request.fail(function(xhr) {
      alert('there was a problem loading the content blocks');
    });
  };

  return PageView;

})();

$(document).ready(function() {
  if($('.momentum-cms-page-view').length > 0) {
    window.PageView = new PageView({el: ('.momentum-cms-page-view')});
  }
});