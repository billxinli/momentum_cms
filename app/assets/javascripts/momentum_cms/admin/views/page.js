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
  PageView.prototype.contentBlocksUrl = function() {
    return this.$el.data('content-blocks-url');
  };

  PageView.prototype.pageId = function() {
    return this.$el.data('page-id');
  };

  //-- Methods --------------------------------------------------------------
  PageView.prototype.bindEvents = function() {
    this.$el.on('change', '.template-select', $.proxy(this.fetchContentBlocks, this));
    this.$('.nav-tabs a').on('click', this.changeTabs);
  };

  PageView.prototype.changeTabs = function(e) {
    if($(e.currentTarget).data('action') == 'add-content') {

    }else{
      e.preventDefault();
      $(this).tab('show');
    }
  };

  PageView.prototype.fetchContentBlocks = function(e) {
    var reqData = {template_id: $(e.currentTarget).val()};
    if(this.pageId() !== '') {
      reqData.page_id = this.pageId();
    }
    var request = $.get(this.contentBlocksUrl(), reqData);
    request.then(function(res) {
      $('.tab-pane.active').empty();
      $(res).find('.form-group').appendTo('.tab-pane.active');
      $('.tab-pane.active select.select').each(function(index, item) {
        $(item).select2();
      });
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